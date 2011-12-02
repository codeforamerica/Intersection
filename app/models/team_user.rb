class TeamUser < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  after_create 'create_activity("joined")'
  after_destroy 'create_activity("left")'

  def create_activity(activity)
    Activity.create(:user => self.user, :team => self.team, :activity => 
    "#{self.user.profile.to_url} #{activity} the #{self.team.to_url} team")
  end


end
