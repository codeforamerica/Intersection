class Milestone < ActiveRecord::Base
  has_many :project_milestones
  has_many :projects, :through => :project_milestones
end
