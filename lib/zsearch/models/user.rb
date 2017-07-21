class User < Entity

  SCHEMA = {
      _id: TO_INT,
      url: DEFAULT,
      external_id: DEFAULT,
      name: DEFAULT,
      alias: DEFAULT,
      created_at: DEFAULT,
      active: TO_BOOL,
      verified: TO_BOOL,
      shared: TO_BOOL,
      locale: DEFAULT,
      timezone: DEFAULT,
      last_login_at: DEFAULT,
      email: DEFAULT,
      phone: DEFAULT,
      signature: DEFAULT,
      organization_id: TO_INT,
      tags: DEFAULT,
      suspended: TO_BOOL,
      role: DEFAULT
  }.freeze

  def self.schema
    SCHEMA
  end

  def add_tickets(tickets)
    tickets.each_with_index do |ticket, index|
      self.send("ticket_#{index}=", "#{ticket.subject} (#{ticket.status})")
    end
  end

  def add_org(organization)
    self.organiztion_name = organization.name if organization
  end

end