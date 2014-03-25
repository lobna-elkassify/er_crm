class Reservation
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def self.all
    [Reservation.new(1), Reservation.new(2), Reservation.new(3), Reservation.new(4)]
  end

  def self.find(id)
    Reservation.all.select{|reservation| reservation.id == id}.first
  end

  def self.table_exists?
    false
  end
end