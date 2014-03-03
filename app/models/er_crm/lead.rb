module ErCrm
  class Lead < ActiveRecord::Base
    belongs_to :customer
    belongs_to :department
    belongs_to :lead_category
    belongs_to :lead_type
    belongs_to :follow_up
  end
end
