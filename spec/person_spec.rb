require_relative '../person'
require_relative '../rental'
require_relative '../book'

describe Person do
  before(:each) do
    @person = Person.new(26, 'Ermiyas', parent_permission: true)
    @book = Book.new('The Alchemist', 'Paulo Coelho')
  end

  describe '#new' do
    context 'when the person' do
      it 'returns a person object' do
        expect(@person).to be_an_instance_of(Person)
      end
    end
  end

  describe '#can_use_services?' do
    context 'when the person' do
      it 'checks if the person can use the services' do
        expect(@person.can_use_services?).to be true
      end
    end
  end

  describe '#correct_name' do
    context 'when the person' do
      it 'checks if the person has a correct name' do
        expect(@person.correct_name).to eq('Ermiyas')
      end
    end
  end

  describe '#add_rentals' do
    context 'when the person is a student' do
      it 'checks if the person has a rental' do
        @rental = Rental.new('2021-01-01', @book, @person)
        expect(@person.rentals).to include(@rental)
      end
    end
  end

  describe '#age' do
    context 'when the person' do
      it 'checks if the person has an age' do
        expect(@person.age).to be >= 18
      end
    end
  end
end
