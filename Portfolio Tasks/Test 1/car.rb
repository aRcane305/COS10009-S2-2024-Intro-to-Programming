require_relative "./input_functions"

# create a class for car attributes
class Car
	attr_accessor :id, :manufacturer, :model, :kilometres
	def initialize(id, manufacturer, model, kilometres)
		@id = id
		@manufacturer = manufacturer
		@model = model
		@kilometres = kilometres
	end
end

# read in the car attributes and assign them to the class
# car_id is an integer, the rest are strings.
def read_a_car()
	car_id = read_integer("Enter car id:")
	car_manufacturer = read_string("Enter manufacturer:")
	car_model = read_string("Enter model:")
	car_kilometres = read_string("Enter kilometres:")
	Car.new(car_id, car_manufacturer, car_model, car_kilometres)
end

# use an array to call the function read_a_car as many times as car_amount requires
# use car_amount to control the iterations in the array later on
def read_cars()
	car_amount = read_integer("How many cars are you entering:")
	cars = Array.new()
	count = car_amount
	index = 0
	while index < count
		car = read_a_car()
		cars[index] = car
		index += 1
	end
	return cars
end

# outputs the car attributes inputted earlier onto the terminal
def print_a_car(a_car)
	puts("Id: #{a_car.id}")
	puts("Manufacturer: #{a_car.manufacturer}")
	puts("Model: #{a_car.model}")
	puts("Kilometres: #{a_car.kilometres}")
end

# using an array, iterates the above print_a_car function according to the length of the array
def print_cars(cars)
	index = 0
	times = cars.length
	while index < times
		print_a_car(cars[index])
		index += 1
	end
end

def main()
	cars = read_cars()
	print_cars(cars)
end

main()