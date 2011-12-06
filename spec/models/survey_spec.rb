require 'spec_helper'

describe Survey do

  it "should return a list of surveys currently active" do
    Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week)
    Factory(:survey, :start_date => 1.month.ago, :end_date => 1.week.ago)
    Survey.active_surveys.size.should == 1
  end

  it "should return a surveys date array" do
    Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1)
    Survey.last.survey_date_array.size.should == 3
    Factory(:survey, :start_date => 3.weeks.ago, :end_date => Time.now + 1.week, :frequency => 2)
    Survey.last.survey_date_array.size.should == 3  
    Factory(:survey, :start_date => 8.weeks.ago, :end_date => Time.now + 1.week, :frequency => 8)
    Survey.last.survey_date_array.size.should == 2  
  end

  it :generate_fellow_survey_responses do
    ut = Factory(:user_type, :name => "Fellow")
    2.times {Factory(:profile, :user_type => ut, :user => Factory(:user))}
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    survey.generate_fellow_survey_responses
    survey.survey_responses.size.should == 2
    User.first.survey_responses.size.should == 1
    User.first.surveys.size.should == 1
  end

  it :generate_team_survey_responses do
    2.times {Factory(:team)}
    2.times {Factory(:user)}
    Team.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Team")
    survey.generate_team_survey_responses
    survey.survey_responses.size.should == 4
    Team.first.survey_responses.size.should == 2
  end
  
  it :generate_project_survey_responses do
    2.times {Factory(:project)}
    2.times {Factory(:user)}
    Project.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Project")
    survey.generate_project_survey_responses
    survey.survey_responses.size.should == 4
    Project.first.survey_responses.size.should == 2
  end

  it "generate project survey responses" do
    2.times {Factory(:project)}
    2.times {Factory(:user)}
    Project.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Project")
    survey.generate_survey_responses
    survey.survey_responses.size.should == 4
    Project.first.survey_responses.size.should == 2
  end
  
  it "generate team survey responses" do
    2.times {Factory(:team)}
    2.times {Factory(:user)}
    Team.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Team")
    survey.generate_survey_responses
    survey.survey_responses.size.should == 4
    Team.first.survey_responses.size.should == 2
  end

  it " generate fellow survey responses" do
    ut = Factory(:user_type, :name => "Fellow")
    2.times {Factory(:profile, :user_type => ut, :user => Factory(:user))}
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    survey.generate_survey_responses
    survey.survey_responses.size.should == 2
    User.first.survey_responses.size.should == 1
    User.first.surveys.size.should == 1
  end

end
