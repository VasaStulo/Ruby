#frozen_string_literal:true

#Подсчитаем, насколько часто встречаются слова в тексте. Для решения этой задачи необходимо:
#Разбить строку на слова
#Подсчитать частоту встречи слов
#Отсортировать по частоте встречи

def main
  file_text = read_txt_file(File.expand_path('text.txt',__dir__))
  words_array = words_from_string(file_text)
  words_frequency = count_words(words_array)
  top_words =  fetch_top_words(words_frequency)
  print_words(top_words)
end

def words_from_string(string)
  string.downcase.scan(/[\p{Alpha}']+/)
end

def read_txt_file(file_name)
  File.read(file_name)
end

#Считает сколько повторений слов(частоту вхождения в массив)
def count_words(words_array)
  frequency = {}
  words_array.each do |word|
    if frequency.key?(word)
      frequency[word] += 1
    else 
      frequency[word] = 1
    end
  end
  frequency
end

#Сортировка по количеству
def fetch_top_words(frequency)
  frequency.sort_by do |word,count|
  -count
  end.first(10) #первые 10 
end

#Метод,чтобы выводилось понятно для пользователей
def print_words(word)
  puts "Наиболее часто встречающиеся слова: "
  word.each do |word, count|
  puts "#{word}:#{count}"
    end
end

main if __FILE__ == $PROGRAM_NAME