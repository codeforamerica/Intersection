class Survey < ActiveRecord::Base
  validates_presence_of :survey_type, :name, :scale, :start_date, :end_date, :frequency
end
