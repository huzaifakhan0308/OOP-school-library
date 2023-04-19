require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'functionality'
require 'json'

class App < Functionality
  def initialize
    super()
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

  def load_data
    load_books
    load_people
    load_rentals
  end
end
