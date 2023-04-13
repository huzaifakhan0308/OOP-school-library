require_relative 'classroom'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(name, age, parent_permission)
    @classroom = nil
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classrooms(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end
end
