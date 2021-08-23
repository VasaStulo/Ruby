class Parent
  def hello
    #SELF ссылается на элемент класса(а-ля this в жабе)
    puts "Hello,my child! From #{self}"
  end
end

class Child < Parent

end

parent = Parent.new
parent.hello

child =Child.new
child.hello

#получим класс к которому относится объект
pp child.class
#получим родительский класс к которому относится объект
pp child.class.superclass