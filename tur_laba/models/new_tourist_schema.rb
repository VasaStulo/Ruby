# frozen_string_literal: true

require 'dry-schema'
require_relative 'scheme_types'

TouristFormSchema = Dry::Schema.Params do
  required(:surname).filled(SchemaTypes::StrippedString)
  required(:name).filled(SchemaTypes::StrippedString)
  required(:patronymic).filled(SchemaTypes::StrippedString)
  required(:list_of_wishes).filled(SchemaTypes::StrippedString)
end
