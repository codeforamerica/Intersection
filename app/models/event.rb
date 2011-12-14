class Event < ActiveRecord::Base
  belongs_to :team
  order("event_date DESC")
end
