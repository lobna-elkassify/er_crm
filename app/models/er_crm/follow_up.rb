module ErCrm
  class FollowUp < ActiveRecord::Base
    has_one :lead, :dependent  => :nullify
    audited :allow_mass_assignment => true
  end
end
