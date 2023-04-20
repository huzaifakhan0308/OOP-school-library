require_relative '../classroom'
require_relative '../student'

describe Classroom do
  before(:each) do
    @classroom = Classroom.new('Maths')
    @student = Student.new(26, 'Maths', 'Ermiyas', parent_permission: true)
  end

  describe '#new' do
    it 'returns a classroom object' do
      expect(@classroom).to be_an_instance_of(Classroom)
    end
  end

  describe '#add_students' do
    context 'when the student' do
      it 'checks if the student has a classroom' do
        @classroom.add_students(@student)
        expect(@student.classroom).to eq(@classroom)
      end
    end
  end
end
