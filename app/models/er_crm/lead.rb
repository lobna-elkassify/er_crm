module ErCrm
  class Lead < ActiveRecord::Base
    #-Associations-----
      belongs_to :customer
      belongs_to :department
      belongs_to :lead_type
      belongs_to :follow_up
      belongs_to :lead_category
      accepts_nested_attributes_for :follow_up, allow_destroy: true

      belongs_to :reservation, :class_name => "Reservation"
      belongs_to :owner_user, :foreign_key => "created_by_user_id", :class_name => "User"
      belongs_to :assigned_user, :foreign_key => "assigned_user_id", :class_name => "User"
    #-----

    #-Validations-----
      validates_presence_of :assigned_user_id, :lead_category_id, :customer_id, :lead_type_id, :lead_type_id
      validate :department_type_category

      def department_type_category
        if !((self.lead_category_id == self.department.category_id) && (self.lead_type.lead_category_id == self.lead_category_id))
          errors.add(:base, "Lead Department/Type category should be the lead category")
        end

        unless self.assigned_user.er_crm_department_ids.include?(self.department_id)
          errors.add(:assigned_user_id, "is not assigned to the lead department")
        end
      end
    #-----

    #-Scopes----
      scope :open, where(:status_id => [Status[:new].id, Status[:active].id])
      scope :sold, where(:status_id => Status[:sold].id)
      scope :closed, where(:status_id => Status[:closed].id)

      scope :open_of_customer, ->(customer_id) {open.where(:customer_id => customer_id)}
      scope :sold_of_customer, ->(customer_id) {sold.where(:customer_id => customer_id)}
      scope :closed_of_customer, ->(customer_id) {closed.where(:customer_id => customer_id)}
    #-----

    audited :allow_mass_assignment => true

    def update_custom_attributes(custom_attributes)
      if custom_attributes[:follow_up_attributes][:date] && custom_attributes[:follow_up_attributes][:hour] &&
         custom_attributes[:follow_up_attributes][:minutes] && custom_attributes[:follow_up_attributes][:meridian]
      
        followup_date = custom_attributes[:follow_up_attributes].delete(:date)
        followup_hour = custom_attributes[:follow_up_attributes].delete(:hour)
        followup_minutes = custom_attributes[:follow_up_attributes].delete(:minutes)
        followup_meridian = custom_attributes[:follow_up_attributes].delete(:meridian)

        custom_attributes[:follow_up_attributes][:datetime] = DateTime.strptime(
                        "#{followup_date} #{followup_hour}:#{followup_minutes} #{followup_meridian}", "%m/%d/%Y %I:%M %p")
      
      end
      self.attributes = custom_attributes
    end

    #-Attributes----
      def status
        Status.find_by_id(self.status_id)
      end

      unless User.table_exists?
        def owner_user; User.find(created_by_user_id); end
        def assigned_user; User.find(assigned_user_id); end
      end

      unless Reservation.table_exists?
        def reservation; Reservation.find(reservation_id); end
      end
    #-----
  end
end
