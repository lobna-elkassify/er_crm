class Region
  attr_accessor :name, :id, :country_id

  def initialize(name, id, country_id)
    @id = id
    @name = name
    @country_id = country_id
  end

  def self.all
    [Region.new('California', 1, 2),
     Region.new('Florida', 2, 2),
     Region.new('Washington', 3, 2)]
  end

  def self.where(filters)
    Region.all
  end

  def self.find(id)
    Region.all.select{|region| region.id == id}.first
  end

  def self.table_exists?
    false
  end
end