require 'dry-types'
# чтобы можно было вводить название или автора книги с пробелами в начале(они удаляются)
module SchemaTypes
  include Dry.Types
  StrippedString = self::String.constructor(&:strip)
end