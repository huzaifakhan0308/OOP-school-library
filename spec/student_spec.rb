require_relative "../student.rb"

describe Student do

    before(:each) do
        @student = Student.new(26, "Huzaifa", parent_permission: true)
    end

    describe "#new" do
        it "returns a student object" do
            expect(@student).to be_an_instance_of(Student)
        end
    end
end
