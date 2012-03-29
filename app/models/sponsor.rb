class Sponsor < ActiveRecord::Base
	has_many :project_sponsors
	has_many :projects, :through => :project_sponsors
  	# Sponsor.create :name => "john", :identity => "Community Leader", :email => "john@domain.com", :link => "johnblog.com"
  	# Sponsor.create :name => "jeffrey", :identity => "City Leader", :email => "jeffrey@domain.com", :link => "twitter/jeffrey.com"
end
