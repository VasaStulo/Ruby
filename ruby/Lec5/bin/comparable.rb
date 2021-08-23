#Примесь Comparable опирается на то, что в классе будет реализован метод сравнения <=>. 
#Данный метод берёт ссылку на другой объект, сравнивает и возвращает
#Положительное число, если текущий объект «больше»
#Ноль, если текущий объект «равен»
#Отрицательное число, если текущий объект «меньше»

class SizeMatters
  include Comparable
  attr :str
  def <=>(other)
    str.size <=> other.str.size
  end
  def initialize(str)
    @str = str
  end
end

s1 = SizeMatters.new("Z")
s2 = SizeMatters.new("YY")
s3 = SizeMatters.new("XXX")
s1 < s2                       #=> true
s4.between?(s1, s3)           #=> false