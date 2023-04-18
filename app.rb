require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require 'json'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    return puts 'No books found' if @books.empty?

    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    return puts 'No people found' if @people.empty?

    @people.each do |person|
      if person.instance_of?(Student)
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      elsif person.instance_of?(Teacher)
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}, " \
             "specialization: #{person.specialization}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp

    if person_type != '1' && person_type != '2'
      puts 'Invalid option'
      return
    end

    print 'Age: '
    age = gets.chomp

    print 'Name: '
    name = gets.chomp

    if person_type == '1'
      create_student(age, name)
    else
      create_teacher(age, name)
    end

    puts 'Person created successfully'
  end

  def create_student(age, name)
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase == 'y'
    @people << Student.new(age, nil, name, parent_permission: parent_permission)
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp

    @people << Teacher.new(age, specialization, name)
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    display_books_list
    book_index = gets.chomp.to_i

    puts

    display_people_list
    person_index = gets.chomp.to_i

    puts

    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def display_books_list
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def display_people_list
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" \
           "#{person.instance_of?(Teacher) ? ", specialization: #{person.specialization}" : ''}"
    end
  end

  def list_rentals_by_person_id
    print 'ID of person: '
    id = gets.chomp

    selected_rentals = @rentals.select { |rental| rental.person.id == id.to_i }

    return puts "No rentals found for ID(#{id})" if selected_rentals.empty?

    puts 'Rentals:'

    selected_rentals.each do |rental|
      puts "#{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end

  def add_data
    write_books_to_file
    write_people_to_file
    write_rentals_to_file
  end

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

  def load_data
    load_books
    load_people
    load_rentals
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
