class Country
  attr_accessor :name, :id, :iso2

  def initialize(name, iso2, id)
    @id = id
    @iso2 = iso2
    @name = name
  end

  def self.all
    [Country.new('Egypt', 'EG', 1),
     Country.new('United States', 'US', 2),
     Country.new('France', 'FR', 3)]
  end

  def self.find(id)
    Country.all.select{|user| user.id == id}.first
  end
end