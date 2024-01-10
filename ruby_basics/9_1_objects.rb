module Speak
  def speak(sound)
    puts "#{sound}"
  end

  def whisper(sound)
    puts "#{sound}".downcase
  end

  def yell(sound)
    puts "#{sound}".upcase
  end
end

class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self_identify
    puts "My name is #{@name}"
  end

  include Speak
end

fido = GoodDog.new('Fido')
fido.speak('Rawr')
fido.whisper('Rawr')
fido.yell('Rawr')
fido.self_identify

puts fido.name

fido.name = 'Sparky'

puts fido.name

GoodDog.ancestors
