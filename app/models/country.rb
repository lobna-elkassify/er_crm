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
    Country.all.select{|country| country.id == id}.first
  end

  def self.usa
    Country.all.select{|country| country.iso2.try(:downcase) == 'us'}.first
  end

  def self.table_exists?
    false
  end
end