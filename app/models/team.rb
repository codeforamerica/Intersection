class Team < ActiveRecord::Base
  has_many :team_projects, :dependent => :destroy
  has_many :team_users, :dependent => :destroy
  has_many :projects, :through => :team_projects
  has_many :users, :through => :team_users
  has_many :events
  has_many :activities
  has_many :survey_responses, :as => :surveyable
  has_many :batchbook_lists, :dependent => :destroy
  has_many :stories
  attr_accessible :logo
  accepts_nested_attributes_for :team_projects, :allow_destroy => true
  accepts_nested_attributes_for :team_users, :allow_destroy => true
  accepts_nested_attributes_for :batchbook_lists, :allow_destroy => true
  
  has_attached_file :logo, :styles => { :thumb => "50x50#", :icon => "30x30#" }

  scope :active_teams, where(:active => true)

  def project_activities
    ids = self.projects.map(&:id)
    if ids.blank?
      []
    else
      Activity.where("project_id in (#{ids.join(',')})").order("created_at DESC")
    end
  end

  def survey_average(time1=1.month.ago, time2=Time.now)
    resp_array = self.survey_responses.taken.during(time1, time2)
    if resp_array.size > 0
      resp_array.collect(&:response).sum/resp_array.size
    else
      0
    end
  end

  def to_url
    "<a href='/teams/#{self.name}'>#{self.name}</a>"
  end

  def all_members
    members = self.users
    self.projects.each do |project|
      members << project.users
    end
    members.uniq
  end

  def network_growth(time1=Date.new(2012,1,1), time2=Time.now)
    previous = 0
    current = 0
    self.batchbook_lists.each do |list|
      histories = list.batchbook_list_histories.during(time1, time2).order("created_at DESC")
      puts histories.inspect
      if !histories.blank?
      previous += histories.last.contact_number
      current += histories.first.contact_number
      end
    end
    #return the current number, and put up or down the amount
    current==0 ? [0, 0, 0] : [current, 100*((current-previous).to_f/previous.to_f), current==previous ? current : current - previous]
  end

  def self.network_growth
    Team.all.map { |x| [x, x.network_growth] }
  end

  def network_growth_by_month
    data = []
    6.times { |x|
      data << [x.months.ago.strftime('%m/%y'), self.network_growth((x+1).months.ago, x.months.ago)[0]]
    }
    data.reverse
  end

  def self.all_network_growth_by_month
    data = Team.all.map { |team|
      team.network_growth_by_month
    }
    new_data = data.first.map {|x| [x[0],0]}
    data.each do |d|
      i=0
      d.map {|x| new_data[i][1] += x[1]; i+=1}
    end
    new_data
  end

end
