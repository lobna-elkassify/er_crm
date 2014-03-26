module ErCrm
  class FollowUp < ActiveRecord::Base
    has_one :lead, :dependent  => :nullify
    audited :allow_mass_assignment => true

    validates_presence_of :datetime
  end
end
