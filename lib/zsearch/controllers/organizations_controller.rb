class OrganizationsController

  # Search for organizations that match a field with the given value.
  # The value is expected to be a String, this method will take care of
  # casting it to relevant data type.
  # i.e. search(name, "zendesk")
  def search(field, value)
    field = field.to_sym
    validate_field(field)
    organizations =  Finder.new(ZendeskService.new.list_organizations, Organization)
    selected_orgs = field == :_id ? [organizations.find_by_id( value)] : organizations.find_all(field, value)
    selected_orgs.compact!
    enrich_orgs(selected_orgs)
    selected_orgs
  end

  private

  def validate_field(field)
    raise FieldNotValid.new(field) unless Organization.fields.include?(field)
  end

  def enrich_orgs(orgs)
    add_users(orgs)
    add_tickets(orgs)
  end

  def add_tickets(orgs)
    unless orgs.empty?
      # add tickets information to the organizations that we found
      tickets = Finder.new(ZendeskService.new.list_tickets, Ticket)
      orgs.each do |org|
        org_tickets = tickets.find_all(:organization_id, org._id)
        org.add_tickets(org_tickets)
      end
    end
  end

  def add_users(orgs)
    unless orgs.empty?
      # add users information to the organizations that we found
      users = Finder.new(ZendeskService.new.list_users, User)
      orgs.each do |org|
        org.add_users(users.find_all(:organization_id, org._id))
      end
    end
  end

end