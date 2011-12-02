class Project < ActiveRecord::Base
  has_many :links
  has_many :project_milestones
  has_many :milestones, :through => :project_milestones
  has_many :team_projects 
  has_many :teams, :through => :team_projects
  
  accepts_nested_attributes_for :links, :allow_destroy => true
  accepts_nested_attributes_for :project_milestones, :allow_destroy => true

  def active_milestone
    project_milestones.where(:active => true).first
  end

end
