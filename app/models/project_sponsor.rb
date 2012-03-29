class ProjectSponsor < ActiveRecord::Base
	belongs_to :project
	belongs_to :sponsor
end
