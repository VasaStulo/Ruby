# frozen_string_literal: true

require 'tty-prompt'

require_relative '../lib/record'
require_relative '../lib/records'

# class Menu
class Menu
  def initialize
    @records = Records.new
    @records.read_in_csv_data(File.expand_path('../data/input.csv', __dir__))
  end

  def display_menu
    loop do
      puts "\n1)Добавить/удалить знакомого"
      puts '2)Изменить адрес, телефон, статус'
      puts '3)Вывести список всех дней рождения, сгруппированный по месяцам'
      puts '4)Отобразить список всех имеющихся статусов. Cформировать список приглашенных лиц,'
      puts 'для каждого создать отдельный файл с соответствующим названием, содержащий внутри:'
      puts 'обращение и текст приглашения'
      puts '5)Составить статистику знакомых'
      puts "6)Завершить работу\nВведите число:"
      ans = gets.chomp

      if ans == '1'
        puts "Если вы хотите добавить знакомого, введите => 1\nЕсли вы хотите удалить знакомого, введите =>2"
        answer = gets.chomp

        if answer == '1'
          @records.add_new_record(read_new_record)
          puts 'Знакомый успешно добавлен!'
        end

        if answer == '2'
          @records.delete_element(get_phone_number)
          puts 'Знакомый успешно удален!'
        end
        next
      end
      if ans == '2'
        change, ans = asking_what_to_change
        @records.change_attribute_of_element(get_phone_number, change, ans)
        puts 'Изменения успешно сохранены!'
        next
      end

      if ans == '3'
        sorted_list = @records.sort_date_by_month
        sorted_list.each do |el|
          puts el.birthday
        end
        next
      end

      if ans == '4'

        @prompt = TTY::Prompt.new
        choice = @prompt.select('Выберите статус', @records.statuses)
        puts 'Введите событие'
        holiday = gets.chomp
        holiday = holiday.to_s.downcase.capitalize

        puts 'Введите путь в файловой системе для списка гостей: '
        path = gets.chomp
        puts 'Введите название файла: '
        file = gets.chomp
        puts 'Введите путь в файловой системе для приглашений: '
        path = gets.chomp
        @records.list_of_guests(@records.list_of_invitees_by_status(choice), path, file)
        @records.creating_invitations_file(holiday, @records.list_of_invitees_by_status(choice), path)
        next
      end

      if ans == '5'

        puts "Общее количество контактов: #{@records.total_amount}"
        puts "Количество контактов женского рода: #{@records.contacts_of_women}"
        puts "Количество контактов мужского рода: #{@records.contacts_of_men}"
        puts "Количество контактов младше 20 лет на данный момент: #{@records.contacts_under20}"
        puts "Количество контактов от 20 до 30 лет на данный момент: #{@records.contacts_20to30}"
        puts "Количество контактов от 30 до 40 лет на данный момент: #{@records.contacts_30to40}"
        puts "Количество контактов старше 40 лет на данный момент: #{@records.contacts_over40}"
        puts "Количество контактов каждого статуса:\n "
        @records.statuses.each do |status|
          puts "#{status}: #{@records.count_statuses(status)}"
        end

        puts 'Для получения количества контактов с указанным домашним телефоном введите домашний телефон >'
        home_telephone = gets.chomp
        if /^[0-9]{6}/.match(home_telephone).nil?
          puts 'В номере может содержтся только 6 цифр'
          return
        end
        @records.count_by_home_phone(home_telephone)
        puts "Количество контактов с указанным домашним номером: #{@records.count_by_home_phone(home_telephone)}"

        puts 'Для получения количества контактов с указанным адресом введите адрес >'
        adr = gets.chomp
        @records.count_by_address(adr)
        puts "Количество контактов с указанным адресом: #{@records.count_by_address(adr)}"
        next
      end
      exit(0) if ans == '6'
    end
  end

  def read_new_record
    new_name = ''
    new_surname = ''
    new_patronymic = ''
    new_cellphone = ''
    new_home_phone = ''
    new_birthday = ''
    new_address = ''
    new_sex = ''
    new_status = ''

    loop do
      loop do
        print 'Введите имя >'
        new_name = gets.chomp
        if /^[а-яА-Я]+$/.match(new_name).nil? || (/^[а-яА-Я]+$/.match(new_name) == 0)
          puts 'В имени могут содержатся только русские буквы'
          next
        end
        break
      end

      loop do
        print 'Введите фамилию >'
        new_surname = gets.chomp
        if /^[а-яА-Я]+$/.match(new_surname).nil? || (/^[а-яА-Я]+$/.match(new_surname) == 0)
          puts 'В фамилии могут содержатся только русские буквы'
          next
        end
        break
      end

      loop do
        print 'Введите отчество (если есть) >'
        new_patronymic = gets.chomp
        if new_patronymic != '' && (/^[а-яА-Я]+$/.match(new_patronymic).nil? || (/^[а-яА-Я]+$/.match(new_patronymic) == 0))
          puts 'В отчестве могут содержатся только русские буквы или пустая строка'
          next
        end
        break
      end

      loop do
        print 'Введите номер сотового телефона (пример: 89038226198) >'
        new_cellphone = gets.chomp
        if /\b^([0-9]{11})$\b/.match(new_cellphone).nil?
          puts 'В номере может содержтся только 11 цифр'
          next
        end

        if @records.is_exist_cellphone(new_cellphone)
          puts 'Человек с таким номером уже существует'
          next
        end
        break
      end

      loop do
        print 'Введите номер домашнего телефона (если есть) >'
        new_home_phone = gets.chomp
        if new_home_phone != '' && /^[0-9]{6}/.match(new_home_phone).nil?
          puts 'В номере может содержтся только 6 цифр'
          next
        end
        break
      end

      print 'Введите адрес проживания (если есть) >'
      new_address = gets.chomp
      loop do
        print 'Введите дату рождения (пример: 21.03.2001) >'
        new_birthday = gets.chomp
        if /([0-2]\d|3[01])\.(0\d|1[012])\.(\d{4})/.match(new_birthday).nil?
          puts 'Дата введена некорректно'
          next
        end
        break
      end
      loop do
        print 'Введите пол (м/ж) >'
        new_sex = gets.chomp
        if /^м{1}|ж{1}/.match(new_sex).nil?
          puts 'Введено неккоректное значение'
          next
        end
        break
      end

      loop do
        print 'Введите статус(друг, парикмахер и т.п.) >'
        new_status = gets.chomp
        if /^[а-яА-Я]+$/.match(new_status).nil?
          puts 'Статус может содержать только буквы кириллицы'
          next
        end
        break
      end
      break
    end
    [new_name, new_surname, new_patronymic, new_cellphone, new_home_phone, new_address, new_birthday, new_sex,
     new_status]
  end

  def get_phone_number
    loop do
      puts 'Введите номер сотового телефона знакомого, которого хотите удалить или изменить его параметры: '
      check_cellphone = gets.chomp

      if /\b^([0-9]{11})$\b/.match(check_cellphone).nil?
        puts 'В номере может содержтся только 11 цифр'
        next
      end
      return check_cellphone
    end
  end

  def asking_what_to_change
    puts "Что вы хотели бы изменить:\n1)Адрес\n2)Сотовый телефон\n3)Домашний телефон\n4)Статус\nВведите число:"
    ans = gets.chomp
    if ans == '1'
      puts 'Введите новый адрес знакомого'
      change_address = gets.chomp
      return change_address, ans
    end

    if ans == '2'
      loop do
        puts 'Введите номер сотового телефона (пример: 89038226198): '
        change_cellphone = gets.chomp

        if /\b^([0-9]{11})$\b/.match(change_cellphone).nil?
          puts 'В номере может содержтся только 11 цифр'
          next
        end
        if @records.is_exist_cellphone(change_cellphone)
          puts 'Человек с таким номером уже существует'
          next
        end
        return change_cellphone, ans
      end
    end

    if ans == '3'
      loop do
        puts 'Введите номер домашнего телефона (пример: 789097): '
        change_home_phone = gets.chomp
        if /^[0-9]{6}/.match(change_home_phone).nil?
          puts 'В номере может содержтся только 6 цифр'
          next
        end
        return change_home_phone, ans
      end
    end

    if ans == '4'
      loop do
        puts 'Введите новый статус знакомого'
        change_status = gets.chomp
        if /^[а-яА-Я]+$/.match(change_status).nil?
          puts 'Статус может содержать только буквы кириллицы'
          next
        end
        return change_status, ans
      end
    end
  end
end
