class Car
  attr_accessor :make, :model, :year
  def initialize(ma, mo, ye)
  puts "hello"
  @make = ma
  @model = mo
  @year = ye
  end
end


car1 = Car.new("Toyota" , "Kluger" , 2023)
car2 = Car.new("BMW" , "Series 5" , 2023)

puts car1.make

puts car2.model