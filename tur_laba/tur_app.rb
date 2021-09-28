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
        @tour_list = opts[:tours].all_tours
        view('tours')
      end
      r.on Integer do |tour_id|
        @tour = opts[:tours].tour_by_id(tour_id)
        r.is do
          view('tour')
        end
        
        r.on 'delete' do
          r.get do
            @parameters = {}
            view('delete_tour')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(TourDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:tours].delete_tour(tour_id)
              r.redirect('/tours')
            else
              view('delete_tour')
            end
          end
        end
      end
        r.on 'new' do
            r.get do
              @parameters = {}
              view('new_tour')
            end
            r.post do
              @parameters = DryResultFormeWrapper.new(TourFormSchema.call(r.params))
                if @parameters.success?
                  opts[:tours].tour_add(@parameters)
                  p opts[:tours]
                  r.redirect "/tours"
                else
                  view('new_tour')
                end
            end
          end
      end
   
    r.on 'tourists' do
      r.is do
        @tourist_list = opts[:tourists].all_tourists
      view('tourists')
      end

      r.on Integer do |tourist_id|
        @tourist = opts[:tourists].tourist_by_id(tourist_id)
        r.is do
          view('tourist')
        end
        r.on 'delete' do
          r.get do
            @parameters = {}
            view('delete_tourist')
          end
          r.post do
            @parameters = DryResultFormeWrapper.new(TouristDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:tourists].delete_tourist(tourist_id)
              r.redirect('/tourists')
            else
              view('delete_tourist')
            end
          end
        end
      end
      r.on 'new' do
        r.get do
          @parameters = {}
          view('new_tourist')
        end
          r.post do
            @parameters = DryResultFormeWrapper.new(TouristFormSchema.call(r.params))
              if @parameters.success?
                opts[:tourists].tourist_add(@parameters)
                r.redirect "/tourists"
              else
                view('new_tourist')
              end
          end
        end
      r.on 'group' do
        @group = opts[:tourists].group_by_counry_and_transport

        @group.each do |group, id|
          p id
        end

        view('group_tourist')
      end
    
    end
  end
end