class Profile < ActiveRecord::Base
  belongs_to :user
  after_update 'create_activity("updated")' 

  def create_activity(activity)
    Activity.create(:user => self.user,:activity => 
      "#{self.to_url} #{activity} their profile")
  end
  
  def to_url
    "<a href='/profiles/#{self.name}'>#{self.name}</a>"
  end
end
