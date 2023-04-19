class Functionality
  def write_books_to_file
    File.write('books.json', JSON.pretty_generate(@books.map do |book|
      {
        author: book.author,
        title: book.title
      }
    end))
  end

  def write_people_to_file
    File.write('people.json', JSON.pretty_generate(@people.map do |person|
      if person.instance_of?(Student)
        {
          class: person.class,
          name: person.name,
          id: person.id,
          age: person.age,
          parent_permission: true
        }
      elsif person.instance_of?(Teacher)
        {
          class: person.class,
          name: person.name,
          id: person.id,
          age: person.age,
          specialization: person.specialization
        }
      end
    end))
  end

  def write_rentals_to_file
    File.write('rentals.json', JSON.pretty_generate(@rentals.map do |rental|
      {
        date: rental.date,
        book: { title: rental.book.title, author: rental.book.author },
        person: { class: rental.person.class, Name: rental.person.name,
                  id: rental.person.id }
      }
    end))
  end

  def load_books
    books = File.read('books.json')
    parsed_books = JSON.parse(books)
    parsed_books.each do |book|
      @books << Book.new(book['title'], book['author'])
    end
  end

  def load_people
    file_contents = File.read('people.json')
    parsed_data = JSON.parse(file_contents)
    parsed_data.each do |person_data|
      case person_data['class']
      when 'Student'
        @people << Student.new(person_data['age'], nil, person_data['name'],
                               parent_permission: person_data['parent_permission'], id: person_data['id'])
      when 'Teacher'
        @people << Teacher.new(person_data['age'], person_data['specialization'], person_data['name'],
                               id: person_data['id'])
      end
    end
  end

  def load_rentals
    rentals = File.read('rentals.json')
    parsed_rentals = JSON.parse(rentals)
    parsed_rentals.each do |rental_data|
      book_found = @books.find { |book| book.title == rental_data['book']['title'] }
      person_found = @people.find { |person| person.id.to_i == rental_data['person']['id'].to_i }
      @rentals << Rental.new(rental_data['date'], book_found, person_found)
    end
  end
end
