require_relative "../book.rb"
require_relative "../person.rb"
require_relative "../rental.rb"

describe Book do
    before(:each) do
        @book = Book.new("The Alchemist", "Paulo Coelho")
    end

    describe "#new" do
        it "returns a book object" do
        expect(@book).to be_an_instance_of(Book)
        end
    
        it "returns the correct title" do
        expect(@book.title).to eq("The Alchemist")
        end
    
        it "returns the correct author" do
        expect(@book.author).to eq("Paulo Coelho")
        end
    end

    describe "#add_rentals" do
        context "when the book is rented" do
        
            it "checks if the book has a rental" do
                expect(@book.rentals).to be_empty
            end

            it "checks if the book has a rental" do
                @person = Person.new(26, "Ermiyas", parent_permission: true)
                @rental = Rental.new("2021-01-01", @book, @person)        
               @book.add_rentals(@person, "2021-01-01")
                expect(@book.rentals).to include(@rental)
            end
        end
    end
end