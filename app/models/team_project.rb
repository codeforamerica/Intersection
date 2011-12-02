class TeamProject < ActiveRecord::Base
  belongs_to :team
  belongs_to :project
  after_create 'create_activity("added")'

  def create_activity(activity)
    Activity.create(:team => self.team, :project => self.project, :activity => 
      "#{self.project.to_url} #{activity} to #{self.team.to_url}</a> team")
  end

end
