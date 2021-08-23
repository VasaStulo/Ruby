class Parent
  def hello
    #SELF ссылается на элемент класса(а-ля this в жабе)
    puts "Hello,my child! From #{self}"
  end
  def to_s
    'parent'
  end
end

class Child < Parent
def hello
  puts"hello from the Child"
end
def to_s
  'child'
end
end

parent = Parent.new
parent.hello

child =Child.new
child.hello

puts parent
puts child