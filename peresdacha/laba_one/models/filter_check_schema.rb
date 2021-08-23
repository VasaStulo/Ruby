# frozen_string_literal: true

require 'dry-schema'

CategoryFilterFormSchema = Dry::Schema.Params do
  optional(:category).maybe(SchemaTypes::StrippedString)
  optional(:start_date).maybe(SchemaTypes::StrippedString)
  optional(:end_date).maybe(SchemaTypes::StrippedString)

  # required(:start_date).value(type?: Date)
end
