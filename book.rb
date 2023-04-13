require_relative 'rental'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rentals(date)
    rental = Rental.new(date)
    @rentals << rental
    rental.book = self
    rental
  end
end
