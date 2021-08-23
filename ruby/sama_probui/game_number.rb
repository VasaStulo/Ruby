# your game
puts "Приветик"
print "Подскажи свое имя "
input = gets
name = input.chomp
puts "Добро пожаловать,#{name}!"
#numb/rand
puts "Я выбрал число от 1 до 100, твоя задача угадать число за 10 попыток "
target = rand(100)+1
#popitka
num_guess = 0
guess_it = false

while num_guess < 11 && guess_it == false

puts "Осталось попыток: #{10 - num_guess}"
print "Попробуй отгадать, введи число "
guess = gets.to_i

#priznak prodol

num_guess += 1
#proverka
if guess < target
  puts "Число больше, чем это, попробуйте еще разок"
elsif guess > target
  puts "Число меньше, чем это, попробуйте еще разок"
elsif guess == target
  puts "Ого, а ты умнее, чем я думал! Молодец! Мое число это #{target} "
  guess_it = true
end

end

  unless guess_it
    puts "Прости, но ты очень глуп. Я загадал число #{target}"
  end
