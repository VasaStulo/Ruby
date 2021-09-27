# frozen_string_literal: true

require 'dry-schema'

TourDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
