class User
  attr_accessor :first_name, :last_name, :email, :id, :avatar, :er_crm_department_ids

  def initialize(first_name, last_name, email, id, er_crm_department_ids)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @er_crm_department_ids = er_crm_department_ids
    @avatar = Avatar.new
  end

  def name 
    [first_name, last_name].join(' ')
  end

  def self.all
    [User.new('Lobna', 'Elkassify', 'lobna@email.com', 1, [7, 9]),
     User.new('Heba', 'Waly', 'heba@email.com', 2, [7, 10]),
     User.new('Wessam', 'Magdy', 'wessam@email.com', 3, [9, 10])]
  end

  def self.find(id)
    User.all.select{|user| user.id == id}.first
  end

  def self.table_exists?
    false
  end

  class Avatar
    def url(size)
      'er_crm/pages/avatar.jpg'
    end
  end
end