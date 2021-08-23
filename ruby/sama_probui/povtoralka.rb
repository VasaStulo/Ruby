if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

puts 'Добрый вечер! Приветствуем в приложении "Повторялка"!'

print 'Введите предложение> '
letter = gets.chomp
puts letter
letter2 = ''
while letter2 != 'stop, please' do
  print 'Если хотите, можете ввести еще предложение >'
  letter2 = gets.chomp
  puts letter2
end
