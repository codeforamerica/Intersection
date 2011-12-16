class SurveyResponse < ActiveRecord::Base
  belongs_to :surveyable, :polymorphic => true
  belongs_to :survey
  belongs_to :user
  scope :active, where("expires_on > ?", Time.now)
  scope :expired, where("expires_on < ?", Time.now)
  scope :taken, where("response != ? or note != ?", 0, nil)
  scope :not_taken, where(:response => nil, :note => nil)
  scope :during, lambda { |time1, time2| where("updated_at BETWEEN ? and ?", time1, time2)} 
  validates_presence_of :survey_id, :user_id, :expires_on, :surveyable_id, :surveyable_type
  validates_uniqueness_of :code
  
  def self.trends
    group("date(survey_responses.created_at)").average(:response)
  end
  
  def self.count_response_trends
    group("date(survey_responses.created_at)").count(:response)
  end

  def self.trends_by_response(num=6)
    date_array = SurveyResponse.group("date(created_at)").count("date(created_at)")
    blank_array = date_array.clone
    new_array = date_array.clone
    blank_array.each {|k,v| blank_array[k]=0}
    new_array.each {|k,v| new_array[k]=[0,0,0]}
    one= self.where(:response => 1).count_response_trends
    two= self.where(:response => 2).count_response_trends
    three= self.where(:response => 3).count_response_trends
    one = blank_array if one.empty?
    two = blank_array if two.empty?
    three = blank_array if three.empty?
    one.each {|k,v| new_array[k][0]=v}
    two.each {|k,v| new_array[k][1]=v}
    three.each {|k,v| new_array[k][2]=v}
    new_array.to_a[0..num].reverse 
    
  end

  def self.trending(num=6)
    s= self.trends
    t = s.to_a
    t[0..num].reverse
  end

end
