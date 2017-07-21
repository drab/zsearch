class ZendeskService

  ROOT_DIR = File.expand_path("../../../..", __FILE__)

  def list_users
    JSON.parse(File.read(File.join(ROOT_DIR, "data/users.json")))
  end

  def list_tickets
    JSON.parse(File.read(File.join(ROOT_DIR, "data/tickets.json")))
  end

  def list_organizations
    JSON.parse(File.read(File.join(ROOT_DIR, "data/organizations.json")))
  end

end