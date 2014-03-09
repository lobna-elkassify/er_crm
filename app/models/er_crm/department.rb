module ErCrm
  class Department < ActiveRecord::Base
    belongs_to :lead_category, foreign_key: "category_id"
    has_many :leads
    
    scope :default, where(:name => ['Central Reservations', 'Los Angeles Self Drive Tours', 'Los Angeles Guided Tours'])
  end
end
