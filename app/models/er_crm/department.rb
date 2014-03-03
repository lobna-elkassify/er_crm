module ErCrm
  class Department < ActiveRecord::Base
    has_many :leads
  end
end
