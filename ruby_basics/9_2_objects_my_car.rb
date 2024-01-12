module TiresReplaceable
  def switch_to_winter_tires
    puts "You have switched all #{@wheels} tires to winter tires. This will keep you safe on the road when it snows!"
  end

  def switch_to_summer_tires
    puts "You have switched all #{@wheels} tires to summer tires. This will reduce unnecessary wear on your expensive winter tires."
  end
end

class Bicycle
  def initialize
    @wheels = 2
    puts 'You just bought a new bike.'
  end

  include TiresReplaceable

  def to_s
    "This is a bike. Don't forget your helmet!"
  end
end

class Vehicle
  attr_accessor :speed
  attr_reader :year, :model, :wheels

  include TiresReplaceable

  def initialize(wheels, year, model)
    @wheels = wheels
    @year = year
    @model = model
    @speed = 0
  end

  def show_age
    puts "This vehicle is #{age} years old."
  end

  def self.calculate_gas_mileage(gallons, miles)
    "This car gets #{miles / gallons} mpg"
  end

  def speed_up(change)
    self.speed += change
  end

  def brake(change)
    self.speed = [0, self.speed - change].max
  end

  def turn_off
    self.speed = 0
  end

  def speedometer
    puts self.speed > 0 ? "You are driving at #{self.speed} mph." : 'You are not moving at the moment.'
  end

  private

  def age
    Time.now.year - year
  end
end

class MyTruck < Vehicle
  WHEELS = 18
  attr_accessor :freight

  def initialize(year, model, freight)
    super(WHEELS, year, model)
    @freight = freight
  end

  def load(new_freight)
    self.freight = new_freight
    puts "You have now loaded #{freight} into the truck."
  end

  def to_s
    "This truck is a #{year} #{model}. It is hauling #{freight}. Its current speed is #{speed}"
  end
end

class MyCar < Vehicle
  attr_accessor :color

  WHEELS = 4

  def initialize(year, model, color)
    super(WHEELS, year, model)
    @color = color
    @speed = 0
  end

  def to_s
    "This lovely vehicle here is a #{year} #{model} in #{color} finish. Its current speed is #{speed}"
  end

  def spray_paint(color)
    self.color = color
  end
end

tesla = MyCar.new(2024, 'Model Y', 'red')
tesla.speed_up(200)
tesla.speedometer
tesla.brake(100)
tesla.speedometer
tesla.turn_off
tesla.speedometer
puts tesla.year
tesla.spray_paint('blue')
puts tesla.color
puts MyCar.calculate_gas_mileage(1, 100)
puts tesla
tesla.show_age

semi = MyTruck.new(2023, 'Tesla Semi', 'Pepsi')
semi.speed_up(200)
semi.speedometer
semi.brake(100)
semi.speedometer
semi.turn_off
semi.speedometer
puts semi.year
puts semi.freight
semi.load('Coke')
puts semi.freight
puts semi
semi.switch_to_winter_tires
semi.switch_to_summer_tires
semi.show_age

bike = Bicycle.new
bike.switch_to_winter_tires
bike.switch_to_summer_tires
puts bike

puts Vehicle.ancestors
puts "\n"
puts MyCar.ancestors
puts "\n"
puts MyTruck.ancestors
puts "\n"
puts Bicycle.ancestors
