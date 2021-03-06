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

  end

end