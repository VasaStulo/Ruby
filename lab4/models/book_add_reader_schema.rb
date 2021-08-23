# frozen_string_literal: true

require 'dry-schema'
require_relative 'scheme_types'

BookAddFormSchema = Dry::Schema.Params do
  required(:number).filled(SchemaTypes::StrippedString)
  required(:date).filled(:date)
end
