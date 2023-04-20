require_relative "../book.rb"

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
end