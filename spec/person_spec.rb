require_relative "../person.rb"
require_relative "../rental.rb"
require_relative "../book.rb"

describe Person do
  
    before(:each) do
        @person = Person.new(26, "Ermiyas", parent_permission: true)
        @book = Book.new("The Alchemist", "Paulo Coelho")
    end

    describe "#new" do
    
        context "when the person" do
            it "returns a person object" do
                expect(@person).to be_an_instance_of(Person)
            end
        end
    end

    describe "#can_use_services?" do
        context "when the person" do
            it "checks if the person can use the services" do
                expect(@person.can_use_services?).to be true
            end
        end
    end
end