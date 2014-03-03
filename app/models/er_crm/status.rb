require_dependency 'constants'

ErCrm::Status = Constants.new({
  :new => {:id => 1, :name => 'New'},
  :active => {:id => 2, :name => 'Active'},
  :closed => {:id => 3, :name => 'Closed'},
  :sold => {:id => 4, :name => 'Sold'}
})