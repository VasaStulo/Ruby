# frozen_string_literal: true

require 'roda'
require_relative 'models'
require 'forme'

class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  plugin :forme
  plugin :view_options

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end
   
  route do |r|
    r.public if [:serve_static]

    r.root do
      r.redirect '/menu'
    end

     r.on 'menu' do
       view('menu')
     end

    #   r.on 'sort' do

    #    view('sort')
    #  end
     r.on 'sort' do
          r.get do 
            @parameters =[]
            view('sort')
          end

          r.post do

            @parameters = DryResultFormeWrapper.new(SortNumbSchema.call(r.params))
            if @parameters.success?
              puts"h"
              # p  @parameters[:numbers].to_i
              # @numb_sort = @parameters[:numbers].split(",").sort
              @numb_sort = @parameters[:numbers].split(',').map(&:to_i).sort
              p @numb_sort
               @numb_sort.each do |numb|
                puts numb
               end
              view('sort')
            # else
            #   view('check_delete')
            # end
          end
        end
      end
  end
  end