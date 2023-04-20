require_relative '../student'

describe Student do
  before(:each) do
    @student = Student.new(26, 'Maths', 'Ermiyas', parent_permission: true)
  end

  describe '#new' do
    it 'returns a student object' do
      expect(@student).to be_an_instance_of(Student)
    end
  end

  describe '#play_hooky' do
    context 'when the student' do
      it 'checks if the student is playing hooky' do
        expect(@student.play_hooky).to eq('¯\\(ツ)/¯')
      end
    end
  end

  describe '#classrooms' do
    context 'when the student' do
      it 'checks if the student has a classroom' do
        expect(@student.classroom).to eq('Maths')
      end
    end
  end
end
