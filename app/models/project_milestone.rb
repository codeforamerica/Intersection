class ProjectMilestone < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
  after_create 'create_activity("added", "to")'
  after_destroy 'create_activity("removed", "from")'
  #Janice updated the Milestone completed date to
  #janice updated the Planned date to 

  def create_activity(activity, verb)
    if $current_user
      Activity.create(:user => $current_user, :project => self.project, :activity =>
        "#{$current_user.profile.to_url} #{activity} milestone '#{self.milestone.name}' #{verb} #{self.project.to_url}")
    else
      Activity.create(:project => self.project, :activity =>
          "Milestone '#{self.milestone.name}' #{activity} #{verb} #{self.project.to_url}</a>")
    end
  end

  #Janice updated a project with Milestone active status
end
