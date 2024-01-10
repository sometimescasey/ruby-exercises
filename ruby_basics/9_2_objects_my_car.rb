class MyCar
  attr_accessor :speed, :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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

  def spray_paint(color)
    self.color = color
  end
end

tesla = MyCar.new(2024, 'red', 'Model Y')
tesla.speed_up(200)
tesla.speedometer
tesla.brake(100)
tesla.speedometer
tesla.turn_off
tesla.speedometer
puts tesla.year
tesla.spray_paint('blue')
puts tesla.color
