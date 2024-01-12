class Student
  attr_reader :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def compare_with(peer)
    if grade > peer.grade
      puts "#{name} did better than #{peer.name}! What a smartypants."
    else
      puts "#{name} did not do better than #{peer.name}. Looks like they need to study more."
    end
  end

  protected

  attr_reader :grade
end

bob = Student.new('Bob', 99)
joe = Student.new('Joe', 50)

bob.compare_with(joe)
joe.compare_with(bob)
bob.grade
