class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :make_profile
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :profile
  has_many :team_users, :dependent => :destroy
  has_many :teams, :through => :team_users
  has_many :project_users, :dependent => :destroy
  has_many :projects, :through => :project_users
  has_many :activities
  has_many :survey_responses, :dependent => :destroy
  has_many :surveys, :as => :surveyable, :class_name => "SurveyResponse"

  def all_survey_average(time1=1.month.ago, time2=Time.now)
    resp_array = self.survey_responses.taken.during(time1, time2)
    if resp_array.size > 0
      resp_array.collect(&:response).sum/resp_array.size
    else
      0
    end
  end
  
  def self_survey_average(time1=1.month.ago, time2=Time.now)
    resp_array = self.survey_responses.taken.during(time1, time2)
    if resp_array.size > 0
      resp_array.collect(&:response).sum/resp_array.size
    else
      0
    end
  end

  def make_profile
    self.create_profile(:name => 'Change Me', :user_type => 'Fellow') unless self.profile
  end
end
