Делает первую букву заглавной
.capitalize

Делает все буквы заглавными
.upcase

Все буквы в обратном порядке
.reverse

Модуль числа
.abs

Четное число
.even?

Посмотреть все методы
.methods

Записывает все эл-ты через запятую
%w{...}

Берет время с ноута на данный момент
today = Time.now

Проверяет день недели
today.saturday?

Программа выполнится 3 раза
3.times do
end

Все элементы с данной позицией
data.each_with_index do |number,index|
  puts "#{index} : #{number}"
end

Все эл-ты удовлетворяющие условию
data.all? {|number|number.odd(возвращает ложь/правда)}

Создать новый массив на основе текущего
data.map{|number|number**2(квадрат чисел)}

Посчитать новую характеристику
data.reduce{|memo(текущая сумма),number(текущий элемент)|number+memo}

Выбрать часть элементов массива(фильтрация>40)
data.select{|number|number>40}

Удаляет все пустые символы,включая перенос
string#strip

Количество элементов массива
либо #size (для массивов )
либо #length (для строк)

Выборка элементов,срез
a.slice(2,3)  (со 2-го элемента выбирает 3 последующих элемента)

Диапозоны чисел
range = 0..2
range.to_a => 0,1,2

Диапозоны строк
str_range = 'а'..'я'
str_range.to_a => а,б,г...я

Изменения массива:
#push, #append — добавить в конец массива
#pop — извлечь элемент из конца массива
#shift — извлечь элемент с начала массива
#unshift, #prepend — добавить в начало массива
#first(n) — получить n первых элементов
#last(n) — получить n последних элементов
#drop(n) — получить элементы массива с позиции n
#shuffle — создать новый массив, перемешав элементы
#delete(obj) — удалить все вхождения объекта obj

Хэши
h = {'dog' => 'canine', 'cat' => 'feline'} либо h = {dog: 'canine', cat: 'feline'}
h.length # => 2
h['dog'] # => "canine"
h[12] = 'dodecine'
h['cat'] = 99

Чтение файла
def read_txt_file(file_name)
  File.read(file_name)
end
def main
  file_text = read_txt_file(File.expand_path('text.txt',__dir__))
  words_array = words_from_string(file_text)
  pp words_array
end
#downcase преобразует строку к нижнему регистру
#scan возвращает массив строк, совпадающих с переданным регулярным выражением
def words_from_string(string)
  string.downcase.scan(/[\w']+/) если символы русские (/[\p{Alpha}']+/)
end

Для сортировки можно использовать метод 
#sort_by, который принимает блок и использует его значения для сортировки
frequency.sort_by do |word,count|
  count (если от большего к меньшему -count)

Вывод 5 наиболее часто встречающихся слов
top_five = sorted.last(5)
for i in 0...5
  word = top_five[i][0]
  count = top_five[i][1]
  puts "#{word}: #{count}"
end
Полезные методы Хешей
#has_key? — проверка на наличие ключа
#has_value? — проверка на наличие значения
#last — получение последних элементов
#sort_by — сортировка элементов
#length — количество элементов
#delete — удалить пару ключ-значение

Возващение значения из блока
class Array
  def find # Вариант реализации find
    each do |value|
      return value if yield(value)
    end
    nil
  end
end
[1, 3, 5, 7, 9].find {|v| v*v > 30} # => 7

Итератор #map (или #collect) позволяет создать новый массив на основе значений текущего массива
["H", "A", "L"].map {|x| x.succ}

Потоки ввода-вывода
f = File.open('testfile')
f.each do |line|
  puts "The line is:  #{line}"
end
f.close

Учёт позиции в итераторе
f = File.open("testfile")
f.each.with_index do |line, index|
  puts "Line  #{index}  is:  #{line}"
end
f.close

Итераторы, использующие логические значения
Метод #any? — есть ли хотя бы один элемент, удовлетворяющий условию
Метод #all? — все ли элементы удовлетворяют условию
Метод #one? — только один элемент удовлетворяет условию
Метод #none? — ни один элемент не удовлетворяет условию
Метод #find — найти первый элемент, удовлетворяющий условию
Метод #find_all — найти все элементы, удовлетворяющие условию
Метод #find_index — найти номер первого элемента, удовлетворяющего условию
Метод #delete_if — удалить из массива все элементы, удовлетворяющие условию

Оператор case
data = '2'
case data
when /^1/, "2"
  puts 'строка начинается с числа 1 или является строкой \'2\''
when /^3/
  puts 'строка начинается с числа 3'
else
  puts 'неизвестная строка'
end

Установка джема
ls - посмотреть какие файлы или папки в папке
1)создаем 2 папки (bin,lib)
2)Gemfile, в корне проекта, куда записываем ресурс и название гема(source 'https://rubygems.org' / gem 'chunky_png')
3)в терминале-> bundle install
ЛИБО ПИШЕМ bundle add write_xlsx
Дабы обновить версию используем bundle update write_xlsx
создать файл(исп джем)-> bundle exec ruby bin/test_xlsx.rb
посмотреть что в файле -> o название.rb

Джем Rubocop
1)Добавление конфигурации:
1.Создаем файл .rubocop.yml
2.Вставляем данную конфигурацию
Metrics/AbcSize:      # Отключение ABC-проверок
  Enabled: false
Metrics/LineLength:   # Длина строк 100
  Max: 100
Metrics/MethodLength: # Количество строк кода 15
  Max: 15
Style/NegatedIf:      # Не форсировать unless
  Enabled: false
2)Вставляем в Gemfile -> gem 'rubocop', require: false
3) Для проверки всех файлов в текущем каталоге достаточно вызывать исполняемый файл джема:
$ bundle exec rubocop
Для проверки конкретных файлов и директорий:
$ bundle exec rubocop lib bin/application.rb
4) автоматического исправления:
$ bundle exec rubocop -a

  #Создание и записывание в файл
  File.open('school.csv', 'w+'){ |file| file.write students}

  #Меняем кодировку ВСЕГДААААА
  chcp 65001

  #Меню
  while true
    puts 'Введите пункт меню:
    1) Сформировать общий список в файл.
    2) Сформировать список классов для школы.
    3) Завершить работу.
    > '

    ans = gets.chomps

    if ans =='1'
      ///////
      puts "1"
    end

    if ans =='2'
      ///////
      puts "2"

    end

    if ans =='3'
      ///////
      puts "3"

    end

  end

  Модуль
  module Trig
    PI = 3.141592654
    def Trig.sin(x) # Определяем метод модуля
      # ..
    end
    def Trig.cos(x)
      # ..
    end
  end
  
  puts Trig::PI # Доступ к константе
  puts Trig.sin(Trig::PI/4) # Вызов метода

  Примеси
  module Debug
    def who_am_i? # Экземпляр метода
      "#{self.class.name} (id: #{self.object_id})"
    end
  end
  class Test
    include Debug # Примешивание модуля Debug
  end