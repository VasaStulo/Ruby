# frozen_string_literal: true

require 'dry-types'
# Module for ignoring gaps in the form
module SchemaTypes
  include Dry.Types
  StrippedString = self::String.constructor(&:strip)
end
