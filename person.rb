require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  attr_accessor :rentals, :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  attr_reader :id

  def can_use_services?
    return unless @age && @parent_permission

    true
  end

  def correct_name
    @name
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end

  def add_rentals(date, _book)
    Rental.new(date, self, person)
  end
end
