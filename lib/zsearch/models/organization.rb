class Organization < Entity

  SCHEMA = {
      _id: TO_INT,
      url: DEFAULT,
      external_id: DEFAULT,
      name: DEFAULT,
      domain_names: DEFAULT,
      created_at: DEFAULT,
      details: DEFAULT,
      shared_tickets: TO_BOOL,
      tags: TO_BOOL
  }.freeze

  def self.schema
    SCHEMA
  end

  def add_users(users)
    users.each_with_index do |user, index|
      self.send("user_#{index}=", user.name)
    end
  end

  def add_tickets(tickets)
    tickets.each_with_index do |ticket, index|
      self.send("ticket_#{index}=", "#{ticket.subject} (#{ticket.status})")
    end
  end

end