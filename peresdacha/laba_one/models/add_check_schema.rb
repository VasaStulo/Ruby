# frozen_string_literal: true

require 'dry-schema'
require_relative 'scheme_types'

CheckAddFormSchema = Dry::Schema.Params do
  required(:date).filled(:date)
  required(:time).filled(SchemaTypes::StrippedString)
  required(:place).filled(SchemaTypes::StrippedString)
  required(:number).value(:integer)

end
