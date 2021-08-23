# frozen_string_literal: true

require 'dry-schema'
require_relative 'scheme_types'

ReaderFormSchema = Dry::Schema.Params do
  required(:surname).filled(SchemaTypes::StrippedString)
  required(:name).filled(SchemaTypes::StrippedString)
  required(:patronymic).filled(SchemaTypes::StrippedString)
  required(:birthday).filled(:date)
end
