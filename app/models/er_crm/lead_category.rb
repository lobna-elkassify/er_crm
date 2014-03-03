module ErCrm
  class LeadCategory < ActiveRecord::Base
    has_many :lead_types
    has_many :leads
  end
end
