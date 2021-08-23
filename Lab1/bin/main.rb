# frozen_string_literal: true

require_relative '../lib/menu'

def main
  menu = Menu.new
  menu.display_menu
end

main if __FILE__ == $PROGRAM_NAME


# Разобраться с attr_reader
# Для названий переменный используется _
# Gemfile.lock проверить почему не совпадает
#  Integer(totalAmount) без обработки выкинет ошибку, если получит в аргументах не корректное число, и приложение завершит работуw