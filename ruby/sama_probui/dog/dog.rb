#frozen_string_literal: true;

class Dog
  #методы записи мы будем определять самостоятельно
  attr_reader :name, :age
  
  def name=(value)
    #Если имя пустое, выводится сообщение об ошибке,и программа прекращается ("raise")
    if value ==""
      raise "Name can't be blank!"
    else
      #Значение переменной экземпляра присваивается,если пройдена проверка
      @name = value
    end
  end

  def age=(value)
    if value < 0
      raise "An age of #{value} isn't valid!"
    else
      @age = value
    end
  end


  def report_age
    puts"#{@name} is #{@age} years old"
  end

  def move(destination)
    puts"#{@name} runs to the #{destination}" 
  end

  def talk
    puts"#{@name} says Bark!"
  end 

end

gogo = Dog.new
gogo.name = "Lolo"
gogo.age = 9
gogo.report_age
gogo.talk
gogo.move("bed")