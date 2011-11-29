class Project < ActiveRecord::Base
  has_many :links
  accepts_nested_attributes_for :links, :allow_destroy => true

end
