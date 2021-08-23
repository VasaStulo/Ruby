# frozen_string_literal: true

require 'roda'
require_relative 'models'

# The class for the main actions in the application
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :view_options

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:students] = Students.new
  opts[:schools] = Schools.new
  opts[:grades] = Grades.new

  route do |r|
    set_layout_options(template: '../views/layout')
    r.public if opts[:serve_static]

    r.root do
      append_view_subdir('schools')
      @list_schools = opts[:schools].list_schools(opts[:students].students)
      @schools = opts[:schools].sort_list_schools(@list_schools)
      r.get do
        @filter_schools = if r.params['type'].nil?
                            @schools
                          else
                            opts[:schools].filter_by_type(@schools, r.params['type'])
                          end
        view('schools')
      end
    end

    r.on 'school' do
      r.on Integer do |school_id|
        @school = opts[:schools].school_by_id(school_id)
        @count_girl = opts[:students].count_girl(@school)
        @count_boys = opts[:students].count_boys(@school)
        @list_grades = opts[:grades].list_grades(opts[:students].students, @school)
        @grades = opts[:grades].sort_grades(@list_grades)

        r.get do
          if r.params['arrow'] == "↓\↑"
            @sort = "↑\↓"
            @sort_grade = @grades.reverse
          else
            @sort = "↓\↑"
            @sort_grade = @grades
          end

          r.is do
            append_view_subdir('schools')
            view('school')
          end

          r.on 'class' do
            r.on Integer do |grade_id|
              @list_classmates = opts[:grades].classmates(opts[:students].students, @school,
                                                          grade_id)
              @students = opts[:students].sort_full_name(@list_classmates)
              r.get do
                @filter_students = if r.params['letter'].nil?
                                     @students
                                   else
                                     opts[:students].filter_by_letter(@students, r.params['letter'])
                                   end

                r.is do
                  append_view_subdir('grade')
                  view('grade')
                end
              end
            end
          end
        end
      end
    end
  end
end
