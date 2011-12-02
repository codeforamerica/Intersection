class Team < ActiveRecord::Base
  has_many :team_projects
  has_many :team_users
  has_many :projects, :through => :team_projects
  has_many :users, :through => :team_users
  
  accepts_nested_attributes_for :team_projects, :allow_destroy => true
  accepts_nested_attributes_for :team_users, :allow_destroy => true
end
