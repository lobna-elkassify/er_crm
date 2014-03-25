module ErCrm
  class Lead < ActiveRecord::Base
    #-Associations-----
      belongs_to :customer
      belongs_to :department
      belongs_to :lead_type
      belongs_to :follow_up
      accepts_nested_attributes_for :follow_up, allow_destroy: true

      belongs_to :reservation, :class_name => "Reservation"
      belongs_to :owner_user, :foreign_key => "created_by_user_id", :class_name => "User"
      belongs_to :assigned_user, :foreign_key => "assigned_user_id", :class_name => "User"
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
