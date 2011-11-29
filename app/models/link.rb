class Link < ActiveRecord::Base
  belongs_to :link_type
  belongs_to :project

  validates_presence_of :link_type_id, :project_id

end
