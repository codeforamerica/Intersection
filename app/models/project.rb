class Project < ActiveRecord::Base
  has_many :links
  accepts_nested_attributes_for :links, :allow_destroy => true

  has_many :project_milestones
  has_many :milestones, :through => :project_milestones
end
