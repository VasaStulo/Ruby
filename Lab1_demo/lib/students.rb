#frozen_string_literal: true

require 'csv'

# if (Gem.win_platform?)
#   Encoding.default_external = Encoding.find(Encoding.locale_charmap)
#   Encoding.default_internal = __ENCODING__

#   [STDIN, STDOUT].each do |io|
#     io.set_encoding(Encoding.default_external, Encoding.default_internal)
#   end
# end

class Students 
  attr_reader :studentsList
  def initialize
    @studentsList = []
  end

  def read_in_csv_data(file_name)
    CSV.foreach(file_name, headers:false) do |row|
      student = Student.new(row[0],row[1], row[2], row[3], row[4], row[5], row[6])
      @studentsList.append(student)
    end
  end

end
