class Link < ActiveRecord::Base
  belongs_to :link_type
  belongs_to :project
  after_create 'create_activity("added", "to")'
  after_destroy 'create_activity("removed", "from")'

  validates_presence_of :link_type_id, :project_id

  def create_activity(activity, verb)
    if $current_user
    Activity.create(:user => $current_user, :project => self.project, :activity => 
      "#{$current_user.profile.to_url} #{activity} #{self.to_url} #{verb} #{self.project.to_url}")
    else
    Activity.create(:project => self.project, :activity => 
      "#{self.to_url} #{activity} #{verb} #{self.project.to_url}</a>")
    end
  end

  def to_url
    "<a href='#{self.url}'>#{self.name}</a>"
  end

end
