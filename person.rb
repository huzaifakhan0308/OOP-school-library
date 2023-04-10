class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_reader :id
  attr_accessor :name, :age

  def of_age?
    return true if @age >= 18

    false
  end

  def can_use_services?
    return unless @age && @parent_permission

    true
  end
end
