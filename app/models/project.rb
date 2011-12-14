class Project < ActiveRecord::Base
  has_many :links, :dependent => :destroy
  has_many :project_milestones, :dependent => :destroy
  has_many :milestones, :through => :project_milestones
  has_many :team_projects, :dependent => :destroy 
  has_many :teams, :through => :team_projects
  has_many :project_users, :dependent => :destroy
  has_many :users, :through => :project_users
  has_many :activities
  has_many :survey_responses, :as => :surveyable
  accepts_nested_attributes_for :links, :allow_destroy => true
  accepts_nested_attributes_for :project_milestones, :allow_destroy => true
  accepts_nested_attributes_for :project_users, :allow_destroy => true
  accepts_nested_attributes_for :team_projects, :allow_destroy => true
  scope :active, where(:active => true)

  after_create 'create_activity("started")'
  after_update 'create_activity("updated")'

  acts_as_taggable
  
  def self.grouped
    group("date(projects.created_at)").size
  end

  def self.month_group
    projects=self.grouped.map { |x| {"#{x[0].to_date.strftime("%m/%y")}" =>  x[1]} }
    projects.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}
  end

  def active_milestone
    am = project_milestones.where(:active => true)
    if am.blank?
      am
    else
      am.first
    end
  end

  def to_url
    "<a href='/projects/#{self.name}'>#{self.name}</a>"
  end

  def survey_average(time1=1.month.ago, time2=Time.now)
  resp_array = self.survey_responses.taken.during(time1, time2)
  if resp_array.size > 0
    resp_array.collect(&:response).sum/resp_array.size
  else
    0
  end
  end
  
  def create_activity(activity)
  
    if $current_user
      Activity.create(:user => $current_user, :project => self, :activity =>
          "#{$current_user.profile.to_url} #{activity} #{self.to_url}")
    else
    Activity.create(:project => self, :activity => 
      "#{self.to_url} #{activity}.")
    end
  end

end
