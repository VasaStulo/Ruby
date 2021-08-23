# frozen_string_literal: true

require 'dry-schema'

BookFilterFormSchema = Dry::Schema.Params do
  optional(:name).maybe(SchemaTypes::StrippedString)
  optional(:genre).maybe(SchemaTypes::StrippedString)
end
