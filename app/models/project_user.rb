class ProjectUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  after_create 'create_activity("joined")'
  after_destroy 'create_activity("left")'

  def create_activity(activity)
    Activity.create(:user => self.user, :project => self.project, :activity => 
      "#{self.user.profile.to_url} #{activity} the #{self.project.to_url} project")
  end

end
