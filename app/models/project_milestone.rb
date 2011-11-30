class ProjectMilestone < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
end
