module ErCrm
  class Lead < ActiveRecord::Base
    #-Associations-----
      belongs_to :customer
      belongs_to :department
      belongs_to :lead_type
      belongs_to :follow_up
      accepts_nested_attributes_for :follow_up

      belongs_to :reservation, :class_name => "Reservation"
      belongs_to :owner_user, :foreign_key => "created_by_user_id", :class_name => "User"
      belongs_to :assigned_user, :foreign_key => "assigned_user_id", :class_name => "User"
    #-----

    #audited :allow_mass_assignment => true

    #-Attributes----
      def status
        Status.find_by_id(self.status_id)
      end

      #Uncoment these lines if the enngine is run from the dummy hosting app
        # def owner_user
        #   User.find(created_by_user_id)
        # end

        # def assigned_user
        #   User.find(assigned_user_id)
        # end

        # def reservation
        #   Reservation.find(reservation_id)
        # end
      #-----
    #-----
  end
end
