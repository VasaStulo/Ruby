# frozen_string_literal: true

require 'dry-schema'

TouristDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
