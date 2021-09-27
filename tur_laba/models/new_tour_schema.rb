# frozen_string_literal: true

require 'dry-schema'
require_relative 'scheme_types'

TourFormSchema = Dry::Schema.Params do
  required(:country).filled(SchemaTypes::StrippedString)
  required(:city).filled(SchemaTypes::StrippedString)
  required(:max_people).value(:integer)
  required(:count_days).value(:integer)
  required(:transport).filled(SchemaTypes::StrippedString)
  required(:cost).value(:integer)
  required(:sight).filled(SchemaTypes::StrippedString)
end
