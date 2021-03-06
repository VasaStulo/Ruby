require 'dry-schema'
require_relative 'scheme_types'

BookFormSchema = Dry::Schema.Params do
  required(:title).filled(SchemaTypes::StrippedString)
  required(:author).filled(SchemaTypes::StrippedString)
  required(:published_on).filled(:date)
  required(:mark).filled(:integer, gteq?:1, lteq?: 5)
  required(:circulation).filled(:float,gt?:0)
end