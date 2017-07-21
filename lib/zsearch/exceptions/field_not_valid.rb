class FieldNotValid < StandardError

  def initialize (field)
    @field = field
    super(%Q("#{field}"" is not a valid search field))
  end

end