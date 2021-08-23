class Student
  require 'date'
  attr_reader :surname, :name, :patronymic, :birthday, :sex, :grad, :school

  def initialize(surname, name, patronymic, birthday, sex, grad, school)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @birthday = Date.parse(birthday)
    @sex = sex
    @grad = grad
    @school = school
    # puts @school
    # @school = school
    # @price = Float(price)
  end

  def to_s
    "#{@surname},#{@name},#{@patronymic},#{@birthday},#{@sex},#{@grad},#{@school}"
  end
end
