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
      validates_presence_of :email, :first_name, :last_name, :street_address, :country_id
    #-----

    #-Attributes----
      def source
        Source.find_by_id(self.source_id)
      end

      def name
        [first_name, last_name].select{|n| !n.blank?}.join(' ')
      end

      def address_line
        [self.street_address, self.city].join(' ') + ", #{ self.region.try(:name) } #{self.zip_code}"
      end

      #Uncoment these lines if the enngine is run from the dummy hosting app
        # def region
        #   Region.find(region_id)
        # end

        # def country
        #   Country.find(country_id)
        # end

        # def owner_user
        #   User.find(created_by_user_id)
        # end

        # def user
        #   User.find(customer_user_id)
        # end
      #-----
    #-----
  end
end
