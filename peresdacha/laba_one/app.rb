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
 
  opts[:products] = Products.new
  opts[:checks] = Checks.new

  
  route do |r|
    r.public if [:serve_static]

    r.root do
      r.redirect '/main'
    end
     r.on 'main' do
       view('main')
     end

    r.on 'analiz_category' do
      @parameters = DryResultFormeWrapper.new(CategoryFilterFormSchema.call(r.params))
      @checks = opts[:checks].all_checks
      view('analiz_category')
    end

    r.on 'checks' do
      r.is do
        @checks = opts[:checks].all_checks
      view('checks')
      end

      r.on Integer do |check_id|
        @check = opts[:checks].check_by_id(check_id)
        @list = @check.products_list
        p @list
        next if @check.nil?

        r.is do
          view('check')
        end

        r.on 'delete' do
          r.get do 
            @parameters ={}
            view('check_delete')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(CheckDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:checks].delete_check(check_id)
              r.redirect('/checks')
            else
              view('check_delete')
            end
          end
        end

        r.on 'edit' do
          r.get do 
            @parameters ={}
            view('edit_product')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(CheckDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:checks].delete_check(check_id)
              r.redirect("/check/#{check_id}")
            else
              view('edit_product')
            end
          end
        end
      end
      

      r.on 'new' do
        r.get do
          @parameters ={}
          view('add_check')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(CheckAddFormSchema.call(r.params))
            if @parameters.success?
              check_id = opts[:checks].add_check(@parameters)
              r.redirect "/checks/#{check_id}"
            else
              view('add_check')
            end
        end
      end

    end


  end
end