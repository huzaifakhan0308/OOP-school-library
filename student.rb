require_relative 'classroom'

class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classrooms=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
