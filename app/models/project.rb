class Project < ActiveRecord::Base
  has_many :links
  has_many :project_milestones
  has_many :milestones, :through => :project_milestones
  has_many :team_projects 
  has_many :teams, :through => :team_projects
  has_many :project_users
  has_many :users, :through => :project_users
  has_many :activities
  accepts_nested_attributes_for :links, :allow_destroy => true
  accepts_nested_attributes_for :project_milestones, :allow_destroy => true
  accepts_nested_attributes_for :project_users, :allow_destroy => true

  after_create 'create_activity("started")'
  after_update 'create_activity("updated")'

  def active_milestone
    project_milestones.where(:active => true).first
  end

  def to_url
    "<a href='/projects/#{self.name}'>#{self.name}</a>"
  end

  def create_activity(activity)
  
    if $current_user
      Activity.create(:user => $current_user, :project => self, :activity =>
          "#{$current_user.profile.to_url} #{activity} #{self.to_url}")
    else
    Activity.create(:project => self, :activity => 
      "#{self.to_url} #{activity}.")
    end
  end

end
