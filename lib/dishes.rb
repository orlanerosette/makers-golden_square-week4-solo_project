class Dishes
  def initialize
    @dishes = []
  end

  def add(dish)
    @dishes << dish
  end

  def all
    @dishes
  end
end