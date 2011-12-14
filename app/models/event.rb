class Event < ActiveRecord::Base
  belongs_to :team
  order("updated_at DESC")
end
