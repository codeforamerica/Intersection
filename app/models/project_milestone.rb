class ProjectMilestone < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
  after_create 'create_activity("added", "to")'
  after_destroy 'create_activity("removed", "from")'
  after_update :update_activity

  def create_activity(activity, verb)
    if $current_user
      Activity.create(:user => $current_user, :project => self.project, :activity =>
        "#{$current_user.profile.to_url} #{activity} milestone '#{self.milestone.name}' #{verb} #{self.project.to_url}")
    else
      Activity.create(:project => self.project, :activity =>
          "Milestone '#{self.milestone.name}' #{activity} #{verb} #{self.project.to_url}</a>")
    end
  end

  def update_activity
    if self.planned_date_changed?
      update_planned_date
    elsif self.completed_date_changed?
      update_completed_date
    elsif self.active_changed?
      update_active_status unless self.active == false
    else
    end
  end

  def update_active_status
    #change all other active states on project milestones to false
    self.project.project_milestones.where("active = ? and id != ?", true, self.id).each { |pm| pm.update_attributes(:active => false)}
    if $current_user
      Activity.create(:user => $current_user, :project => self.project, :activity =>
        "#{$current_user.profile.to_url} marked milestone '#{self.milestone.name}' as active")
    else
      Activity.create(:project => self.project, :activity =>
        "Milestone '#{self.milestone.name}' marked as active.")
    end
  end

  def update_completed_date
    if $current_user
      Activity.create(:user => $current_user, :project => self.project, :activity =>
        "#{$current_user.profile.to_url} marked milestone '#{self.milestone.name}' completed on #{self.completed_date.strftime('%m-%d-%y')}")
    else
      Activity.create(:project => self.project, :activity =>
        "Milestone '#{self.milestone.name}' completed on #{self.completed_date.strftime('%m-%d-%y')}")
    end
  end

  def update_planned_date
    if $current_user
      Activity.create(:user => $current_user, :project => self.project, :activity =>
        "#{$current_user.profile.to_url} updated the planned date for milestone '#{self.milestone.name}' from #{self.planned_date_was.try(:strftime, '%m-%d-%y')} to #{self.planned_date.try(:strftime, '%m-%d-%y')}")
    else
      Activity.create(:project => self.project, :activity =>
        "Planned date for milestone '#{self.milestone.name}' updated from #{self.planned_date_was.try(:strftime, '%m-%d-%y')} to #{self.planned_date.try(:strftime, '%m-%d-%y')}")
    end
  end

end
