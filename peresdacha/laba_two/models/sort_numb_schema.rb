# frozen_string_literal: true

require 'dry-schema'

SortNumbSchema = Dry::Schema.Params do
  required(:numbers).filled(SchemaTypes::StrippedString)
end
