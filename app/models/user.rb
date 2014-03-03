class User
  attr_accessor :first_name, :last_name, :email, :id

  def initialize(first_name, last_name, email, id)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
  end

  def name 
    [last_name, first_name].join(' ')
  end

  def self.all
    [User.new('Lobna', 'Elkassify', 'lobna@email.com', 1),
     User.new('Heba', 'Waly', 'heba@email.com', 2),
     User.new('Wessam', 'Magdy', 'wessam@email.com', 3)]
  end

  def self.find(id)
    User.all.select{|user| user.id == id}.first
  end
end