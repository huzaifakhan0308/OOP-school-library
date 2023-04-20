require_relative '../rental'
require_relative '../person'
require_relative '../book'

describe Rental do
  before(:each) do
    @person = Person.new(26, 'Ermiyas', parent_permission: true)
    @book = Book.new('The Alchemist', 'Paulo Coelho')
    @rental = Rental.new('2021-01-01', @book, @person)
  end

  describe '#new' do
    it 'returns a rental object' do
      expect(@rental).to be_an_instance_of(Rental)
    end

    it 'returns the correct date' do
      expect(@rental.date).to eq('2021-01-01')
    end

    it 'returns the correct book' do
      expect(@rental.book).to eq(@book)
    end

    it 'returns the correct person' do
      expect(@rental.person).to eq(@person)
    end
  end
end
