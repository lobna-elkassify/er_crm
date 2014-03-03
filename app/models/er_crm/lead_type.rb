module ErCrm
  class LeadType < ActiveRecord::Base
    belongs_to :lead_category
    has_many :leads
  end
end
