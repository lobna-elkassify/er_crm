class Region
  attr_accessor :name, :id

  def initialize(name, id)
    @id = id
    @name = name
  end

  def self.all
    [Region.new('California', 1),
     Region.new('Florida', 2),
     Region.new('Washington', 3)]
  end

  def self.find(id)
    Region.all.select{|user| user.id == id}.first
  end
end