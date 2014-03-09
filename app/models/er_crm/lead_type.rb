module ErCrm
  class LeadType < ActiveRecord::Base
    belongs_to :lead_category
    has_many :leads

    scope :contact_request, where(:name => "Contact Request")
  end
end
