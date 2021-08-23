# frozen_string_literal: true

require 'dry-schema'

CheckDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
