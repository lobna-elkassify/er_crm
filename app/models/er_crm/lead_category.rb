module ErCrm
  class LeadCategory < ActiveRecord::Base
    has_many :lead_type
  end
end
