class Survey < ActiveRecord::Base
  validates_presence_of :survey_type, :name, :scale, :start_date, :end_date, :frequency
  has_many :survey_responses, :dependent => :destroy
  after_save :check_and_add_responses
  scope :active_surveys, where("surveys.end_date > ?", Time.now)

  def survey_today?
    schedule = IceCube::Schedule.new(self.start_date, {:end_time => self.end_date})
    schedule.add_recurrence_rule IceCube::Rule.weekly(self.frequency.to_i).day(self.start_date.wday)
    schedule.occurs_on?(Time.now)
  end

  def check_and_add_responses
   generate_survey_responses if self.survey_today?
  end

  def delete_expired_responses
    self.survey_responses.expired.not_taken.delete_all
  end

  def generate_survey_responses
    case self.survey_type
    when "Fellow"
      generate_fellow_survey_responses
    when "Team"
      generate_team_survey_responses
    when "Project"
      generate_project_survey_responses
    when "Staff"
      generate_staff_survey_responses
    when "City"
      generate_city_survey_responses
    end

  end

  def generate_fellow_survey_responses
    Profile.where(:user_type => "Fellow").each do |p|
      self.survey_responses.create(:user => p.user, :code =>"#{p.user.id}fellow#{Time.now.strftime('%d%m%y')}" ,:expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "User", :surveyable_id => p.user.id)
    end
  end

  def generate_city_survey_responses
    Profile.where(:user_type => "City").each do |p|
      self.survey_responses.create(:user => p.user, :code =>"#{p.user.id}city#{Time.now.strftime('%d%m%y')}" ,:expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "User", :surveyable_id => p.user.id)
    end
  end

  def generate_staff_survey_responses
    Profile.where(:user_type => "Staff").each do |p|
      self.survey_responses.create(:user => p.user, :code =>"#{p.user.id}staff#{Time.now.strftime('%d%m%y')}" ,:expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "User", :surveyable_id => p.user.id)
    end
  end

  def generate_team_survey_responses
    Team.active_teams.each do |team|
      team.users.each do |u|
        self.survey_responses.create(:user => u, :code =>"#{u.id}team#{team.id}#{Time.now.strftime('%d%m%y')}" , :expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "Team", :surveyable_id => team.id)
      end
    end
  end

  def generate_project_survey_responses
    Project.active.each do |project|
      project.users.each do |u|
        self.survey_responses.create(:user => u, :code =>"#{u.id}project#{project.id}#{Time.now.strftime('%d%m%y')}" , :expires_on => Time.now + (self.frequency.to_i).weeks, :surveyable_type => "Project", :surveyable_id => project.id)
      end
    end
  end

end
