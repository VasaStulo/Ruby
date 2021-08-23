#Классу, использующему модуль Enumerable необходимо реализовать следующие методы:
#итератор each для обхода всех элементов коллекции
#объекты коллекции метод сравнения <=>
#После примеси модуля становятся доступными все его методы:
#map
#find
#reduce
#sort


class VovelFinder
  include Enumerable

  def initialize(string)
    @string = string
  end

  def each
    @string.scan(/[aoeuyi]/) do |vowel|
      yield vowel
    end
  end
end

finder = VovelFinder.new('Money for noting')
finder.each do |vowel|
  puts vowel
end

#еСТЬ ЛИ СРЕДИ ГЛАСНЫХ Y
puts (finder.any? {|vowel| vowel == 'y'})

puts (finder.map{|vowel| vowel.upcase})
