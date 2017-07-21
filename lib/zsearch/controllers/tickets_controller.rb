class TicketsController

  # Search for tickets that match a field with the given value.
  # The value is expected to be a String, this method will take care of
  # casting it to relevant data type.
  # i.e. search(status, "pending")
  def search(field, value)
    field = field.to_sym
    validate_field(field)
    tickets =  Finder.new(ZendeskService.new.list_tickets, Ticket)
    selected_tickets = field == :_id ? [tickets.find_by_id( value)] : tickets.find_all(field, value)
    selected_tickets.compact!
    enrich_tickets(selected_tickets)
    selected_tickets
  end

  private

  def validate_field(field)
    raise FieldNotValid.new(field) unless Ticket.fields.include?(field)
  end

  def enrich_tickets(tickets)
    add_organizations(tickets)
    add_users(tickets)
  end

  def add_users(tickets)
    unless tickets.empty?
      # add tickets information to the tickets that we found
      users = Finder.new(ZendeskService.new.list_users, User)
      tickets.each do |ticket|
        user = users.find_by_id(ticket.submitter_id)
        ticket.add_submitter(user)
      end
    end
  end

  def add_organizations(tickets)
    unless tickets.empty?
      # add tickets information to the tickets that we found
      orgnizations = Finder.new(ZendeskService.new.list_organizations, Organization)
      tickets.each do |ticket|
        ticket.add_org(orgnizations.find_by_id( ticket.organization_id))
      end
    end
  end

end