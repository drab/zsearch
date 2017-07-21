class ZendeskServiceStub
  def list_users
    JSON.parse(File.read('test/data/users.json'))
  end

  def list_tickets
    JSON.parse(File.read('test/data/tickets.json'))
  end

  def list_organizations
    JSON.parse(File.read('test/data/organizations.json'))
  end
end