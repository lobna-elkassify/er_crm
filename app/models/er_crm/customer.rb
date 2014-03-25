module ErCrm
  class Customer < ActiveRecord::Base
    #-Associations-----
      belongs_to :country
      belongs_to :region
      belongs_to :owner_user, foreign_key: "created_by_user_id", class_name: "User"
      belongs_to :user, foreign_key: "customer_user_id", class_name: "User"

      has_many :leads
    #-----

    #-Validations
      validates :email, uniqueness: true, :format => {:with => Devise.email_regexp}, :unless => Proc.new{|c| c.email.blank?}
      validates_presence_of :email, :first_name, :last_name, :home_phone, :street_address

      validate :first_and_last_names_applied

      def first_and_last_names_applied
        if self.first_name.blank? || self.last_name.blank?
          errors.add(:name, "First and Last Name should be applied")
        end
      end
    #-----

    #-Attributes----
      def source
        Source.find_by_id(self.source_id)
      end

      def name
        [first_name, last_name].select{|n| !n.blank?}.join(' ')
      end

      def name=(value)
        first_last_names = value.split(' ').select{|f| !f.blank?}
        if first_last_names.length == 2
          self.first_name = first_last_names.first
          self.last_name = first_last_names.last
        else
          self.first_name = first_last_names.first
          self.last_name = nil
        end
      end

      def address_line
        [self.street_address, self.city].join(' ') + ", #{ self.region.try(:name) } #{self.zip_code}"
      end

      
      unless Region.table_exists?
        def region; Region.find(region_id); end
      end

      unless Country.table_exists?
        def country; Country.find(country_id); end
      end

      unless User.table_exists?
        def owner_user; User.find(created_by_user_id); end
        def user; User.find(customer_user_id); end
      end
    #-----
  end
end
