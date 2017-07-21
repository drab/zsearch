class UsersController

  # Search for users that match a field with the given value.
  # The value is expected to be a String, this method will take care of
  # casting it to relevant data type.
  # i.e. search(active, "true")
  def search(field, value)
    field = field.to_sym
    validate_field(field)
    users =  Finder.new(ZendeskService.new.list_users, User)
    selected_users = field == :_id ? [users.find_by_id( value)] : users.find_all(field, value)
    selected_users.compact!
    enrich_users(selected_users)
    selected_users
  end

  private

  def validate_field(field)
    raise FieldNotValid.new(field) unless User.fields.include?(field)
  end

  def enrich_users(users)
    add_organizations(users)
    add_tickets(users)
  end

  def add_tickets(users)
    unless users.empty?
      # add tickets information to the users that we found
      tickets = Finder.new(ZendeskService.new.list_tickets, Ticket)
      users.each do |user|
        user_tickets = tickets.find_all(:submitter_id, user._id)
        user.add_tickets(user_tickets)
      end
    end
  end

  def add_organizations(users)
    unless users.empty?
      # add tickets information to the users that we found
      orgnizations = Finder.new(ZendeskService.new.list_organizations, Organization)
      users.each do |user|
        user.add_org(orgnizations.find_by_id( user.organization_id))
      end
    end
  end

end