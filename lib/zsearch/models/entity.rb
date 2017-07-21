class Entity < OpenStruct

  DEFAULT = ->(value) {value}
  TO_INT = ->(value) {value.to_i}
  TO_BOOL = ->(value) {value == "true"}

  def self.fields
    schema.keys
  end

  def self.cast(field, value)
    schema.fetch(field).call(value)
  end

end