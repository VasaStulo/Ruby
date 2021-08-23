sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  sum += square
end
puts sum

#Числа фибоначи
def fib_up_to(max)
  i1, i2 = 1, 1 # Паралельное присваивание
  while i1 <= max
    yield i1
    i1, i2 = i2, i1+i2
  end
end
fib_up_to(1000) {|f| print f, " "}