module ErCrm
  class LeadCategory < ActiveRecord::Base
    has_many :departments, foreign_key: "category_id"
    has_many :lead_types
    has_many :leads

    scope :default, where(:name => ['Rentals', 'Self Drive Tours', 'Guided Tours'])
  end
end
