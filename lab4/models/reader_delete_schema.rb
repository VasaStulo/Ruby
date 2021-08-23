# frozen_string_literal: true

require 'dry-schema'

ReaderDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
