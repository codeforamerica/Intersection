class Survey < ActiveRecord::Base
  validates_presence_of :survey_type, :name, :scale, :start_date, :end_date, :frequency
  has_many :survey_responses, :dependent => :destroy
  scope :active_surveys, where("start_date < ? and end_date > ?", Time.now, Time.now)

  def survey_today?
    puts survey_date_array
    puts Time.now.to_date
    puts "\n"
    survey_date_array.include?(Time.now.to_date)
  end

  def survey_date_array
    dates = [self.start_date]
    new_date = start_date
    frequency_weeks = (self.frequency.to_i).weeks
    while new_date < end_date
      new_date =  new_date + frequency_weeks
      dates << new_date unless new_date > self.end_date
    end
    return dates
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
    UserType.where(:name => "Fellow").first.profiles.each do |p|
      self.survey_responses.create(:user => p.user, :expires_on => Time.now + (self.frequency).weeks, :surveyable_type => "User", :surveyable_id => p.user.id)
    end
  end
  
  def generate_team_survey_responses
    Team.active_teams.each do |team|
      team.users.each do |u|
        self.survey_responses.create(:user => u, :expires_on => Time.now + (self.frequency).weeks, :surveyable_type => "Team", :surveyable_id => team.id)
      end
    end
  end
  
  def generate_project_survey_responses
    Project.active.each do |project|
      project.users.each do |u|
        self.survey_responses.create(:user => u, :expires_on => Time.now + (self.frequency).weeks, :surveyable_type => "Project", :surveyable_id => project.id)
      end
    end
  end

end
