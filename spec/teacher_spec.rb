require_relative "../teacher.rb"

describe Teacher do

    before(:each) do
        @teacher = Teacher.new(26, "Maths", "Ermiyas", parent_permission: true)
    end

    describe "#new" do
        it "returns a teacher object" do
            expect(@teacher).to be_an_instance_of(Teacher)
        end
    end
end