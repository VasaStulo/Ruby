# frozen_string_literal: true

require 'dry-schema'
require_relative 'scheme_types'

BookFormSchema = Dry::Schema.Params do
  required(:author).filled(SchemaTypes::StrippedString)
  required(:title).filled(SchemaTypes::StrippedString)
  required(:number).filled(SchemaTypes::StrippedString)
  required(:genre).filled(SchemaTypes::StrippedString)
  required(:age_rating).filled(:integer, gt?: 0)
end

# rule (:author) do 
# unless /\[А-Я]{1}\.[А-Я]{1}\.[А-Я]
# end 