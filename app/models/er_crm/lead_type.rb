module ErCrm
  class LeadType < ActiveRecord::Base
    belongs_to :lead_category
  end
end
