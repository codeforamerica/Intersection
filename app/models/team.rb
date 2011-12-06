class Team < ActiveRecord::Base
  has_many :team_projects, :dependent => :destroy
  has_many :team_users, :dependent => :destroy
  has_many :projects, :through => :team_projects
  has_many :users, :through => :team_users
  has_many :activities
  has_many :survey_responses, :as => :surveyable
  accepts_nested_attributes_for :team_projects, :allow_destroy => true
  accepts_nested_attributes_for :team_users, :allow_destroy => true
  
  scope :active_teams, where(:active => true)

  def project_activities
    ids = self.projects.map(&:id)
    Activity.where("project_id in (#{ids.join(',')})").order("created_at DESC")    
  end

  def to_url
    "<a href='/teams/#{self.name}'>#{self.name}</a>"
  end
end
