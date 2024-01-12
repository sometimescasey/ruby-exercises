class Animal
  attr_reader :sound

  def initialize
    @sound = 'generic rustling'
  end

  def what_am_i
    p 'I am a living being worthy of love'
  end

  def speak
    p sound
  end
end

module Swimmable
  def swim
    puts "#{sound} I am swimming swimming in my swimming pool"
  end
end

class Mammal < Animal
  def regulate
    p 'I am regulating my body temperature from within'
  end
end

class Cat < Mammal
  def initialize
    super()
    @sound = 'Meeeeeow'
  end
end

class Dog < Mammal
  include Swimmable
  def initialize
    super()
    @sound = 'Ruff ruff'
  end
end

class Fish < Animal
  include Swimmable
  def initialize
    super()
    @sound = 'Splish splash'
  end
end

cat = Cat.new
dog = Dog.new
fish = Fish.new

cat.speak
dog.speak
fish.speak
dog.swim
fish.swim
