# frozen_string_literal: true

require 'roda'
require_relative 'models'
require 'forme'

# for prosto tak
class TestApp < Roda

  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :forme

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:tests] = TestList.new([
    Test.new('Лабораторная №1','2020-04-05','Проверку знаний по языку Ruby'),
    Test.new('Лабораторная №2','2020-04-25','Проверку по языку Ruby'),
    Test.new('Финальный экзамен','2020-10-25','Ruby'),
  ])
 

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      'Hi'
    end

    r.on 'tests' do

      r.is do
      @params = DrySchemeFormeAdapter.new(FilterFromSchema.call(r.params))
      @filter_tests = if @params.success?
                      opts[:tests].filter(@params[:date],@params[:duration])
                      else
                        opts[:tests].all_tests
                      end

      view('tests')
      
      end

      r.on 'new' do

        r.get do 
          @params = {}
          view('new_test')
        end

        r.post do
          @params = DrySchemeFormeAdapter.new(NewTestFormSchema.call(r.params))
          if @params.success?
            opts[:tests].add_test(Test.new(@params[:name],@params[:date],@params[:duration]))
            r.redirect '/tests'
          else
          view('new_test')
        end
      end
      end
    end
  end
end
