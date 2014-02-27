require_dependency 'constants'

ErCrm::Source = Constants.new({
  :online => {:id => 1, :name => 'Online'},
  :call => {:id => 2, :name => 'Call'},
  :walk_in => {:id => 3, :name => 'Walk In'}
})