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

  opts[:tours] = TourList.new
  opts[:tourists] = TouristList.new

  route do |r|
    r.public if [:serve_static]

    r.root do
      r.redirect '/menu'
    end
    
    r.on 'menu' do
       view('menu')
    end

    r.on 'tours' do
      r.is do
        # p  opts[:tours]
        @tour_list = opts[:tours].all_tours
      view('tours')
      end

    end

    r.on 'tourists' do
      r.is do
        # p  opts[:tours]
        @tourist_list = opts[:tourists].all_tourists
      view('tourists')
      end

    end

    


  end
end