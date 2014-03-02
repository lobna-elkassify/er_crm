class User
  attr_accessor :name, :id

  def initialize(name, id)
    @id = id
    @name = name
  end

  def self.all
    [User.new('Lobna', 1),
     User.new('Heba', 2),
     User.new('Wessam', 3)]
  end

  def self.find(id)
    User.all.select{|user| user.id == id}.first
  end
end