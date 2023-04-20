require_relative 'nameable'

class BaseDecorater < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < BaseDecorater
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < BaseDecorater
  def correct_name
    name = @nameable.correct_name[0, 10]
    name.size < 10 ? name : "#{name}..."
  end
end
