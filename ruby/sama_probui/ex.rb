class Dog
  def talk (name)
    puts "Bark!"
  end
  def move (name, destination)
    puts "Running to the #{destination}"
  end
end

class Bird
  def talk (name)
    puts"Chirik"
  end
  def move (name, destination)
    puts "#{name} flying to the #{destination}"
  end
end

class Cat
  def talk(name)
    puts"Maaaaaaaaaaau mau mau"
  end
  def move (name,destination)
    puts "Running to the #{destination}"
  end
end

dog = Dog.new
cat = Cat.new
bird = Bird.new

dog.move ("house")
bird.talk
cat.talk

