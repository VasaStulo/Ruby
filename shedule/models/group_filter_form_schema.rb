# frozen_string_literal: true

require 'dry-schema'

GroupFilterFormSchema = Dry::Schema.Params do
  optional(:name).maybe(SchemaTypes::StrippedString)
end
