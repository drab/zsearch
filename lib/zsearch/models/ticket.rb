class Ticket < Entity

  SCHEMA = {
      _id: DEFAULT,
      url: DEFAULT,
      external_id: DEFAULT,
      created_at: DEFAULT,
      type: DEFAULT,
      subject: DEFAULT,
      description: DEFAULT,
      priority: DEFAULT,
      status: DEFAULT,
      submitter_id: TO_INT,
      assignee_id: TO_INT,
      organization_id: TO_INT,
      tags: DEFAULT,
      has_incidents: TO_BOOL,
      due_at: DEFAULT
  }.freeze

  def self.schema
    SCHEMA
  end

  def add_submitter(user)
    self.submitter_name = user.name if user
  end

  def add_org(organization)
    self.organiztion_name = organization.name if organization
  end

end