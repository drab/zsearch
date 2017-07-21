class Finder

  def initialize(items, klass)
    # build an hash of _id => item
    @items = items.map { |h| [h["_id"], klass.new(h)]}.to_h
    @klass = klass
  end

  def find_by_id(id)
    id = @klass.cast(:_id, id)
    @items[id]
  end

  def find(field, value)
    value = @klass.cast(field, value)
    return find_by_id(value) if [:id, :_id].include?(field)
    # the requested field is not an id, since we currently only index the id
    # we need to iterate over the items and find the first item that matches
    # the given value
    @items.values.find {|u| u[field] == value }
  end

  # Returns an array of all the items which have a field with a matching value.
  def find_all(field, value)
    value = @klass.cast(field, value)
    @items.values.select do |u|
      field_value = u[field]
      if field_value.is_a? Array
        field_value.any? { |item| item == value }
      else
        field_value == value
      end
    end
  end

end