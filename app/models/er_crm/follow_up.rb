module ErCrm
  class FollowUp < ActiveRecord::Base
    has_one :lead
  end
end
