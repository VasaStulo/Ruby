# frozen_string_literal: true

require_relative '../lib/menu'

def main
  menu = Menu.new
  menu.display_menu
end

main if __FILE__ == $PROGRAM_NAME
