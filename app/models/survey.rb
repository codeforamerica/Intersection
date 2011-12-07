class Survey < ActiveRecord::Base
  validates_presence_of :survey_type, :name, :scale, :start_date, :end_date, :frequency
  has_many :survey_responses, :dependent => :destroy

  def survey_today?
    schedule = IceCube::Schedule.new(self.start_date, {:end_time => self.end_date})
    schedule.add_recurrence_rule IceCube::Rule.weekly(self.frequency.to_i).day(self.start_date.wday)
    schedule.occurs_on?(Time.now)
  end


  def generate_survey_responses
    case self.survey_type
    when "Fellow"
      generate_fellow_survey_responses
    when "Team"
      generate_team_survey_responses
    when "Project"
      generate_project_survey_responses
    end
  end

  def generate_fellow_survey_responses
    Profile.where(:user_type => "Fellow").each do |p|
      self.survey_responses.create(:user => p.user, :expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "User", :surveyable_id => p.user.id)
    end
  end
  
  def generate_team_survey_responses
    Team.active_teams.each do |team|
      team.users.each do |u|
        self.survey_responses.create(:user => u, :expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "Team", :surveyable_id => team.id)
      end
    end
  end
  
  def generate_project_survey_responses
    Project.active.each do |project|
      project.users.each do |u|
        self.survey_responses.create(:user => u, :expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "Project", :surveyable_id => project.id)
      end
    end
  end

end
