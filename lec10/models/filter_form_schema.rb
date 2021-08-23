require 'dry-schema'

FilterFromSchema = Dry::Schema.Params do
  optional(:date).maybe(:string, format?: /\d{4}-\d{2}-\d{2}/)
  optional(:duration).maybe(:string)
end