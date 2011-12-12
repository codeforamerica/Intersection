require 'spec_helper'

describe Survey do
  
  describe "various time differences for surveys with timecop" do

    it "1 week out on 1 week frequency" do
      Factory(:survey, :start_date => Time.now, :end_date => Time.now + 1.month)
       Timecop.freeze(Time.now + 1.weeks) do
        Survey.last.survey_today?.should be_true
      end
    end
    
    it "15 weeks out on 2 week frequency" do
      Factory(:survey, :start_date => Time.now, :end_date => Time.now + 1.year, :frequency => "2")
      Timecop.freeze(Time.now + 15.weeks) do
        Survey.last.survey_today?.should be_false
      end
    end

  end

  it "should delete expired survey responses where note and response are nil" do
    survey = Factory(:survey)
    sr = Factory(:user_survey_response, :response => 1, :note => nil, :expires_on => 1.week.ago, :survey => survey)
    sr = Factory(:user_survey_response, :note => "something", :response => nil, :expires_on => 1.week.ago, :survey => survey)
    sr = Factory(:user_survey_response, :note => nil, :response => nil, :expires_on => 1.week.ago, :survey => survey)
    SurveyResponse.count.should == 3
    sr.survey.delete_expired_responses
    SurveyResponse.count.should == 2

  end

  it "should return a list of surveys currently active" do
    Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week)
    Factory(:survey, :start_date => 1.month.ago, :end_date => 1.week.ago)
    Survey.active_surveys.size.should == 1
  end

  it :generate_fellow_survey_responses do
    2.times {Factory(:user)}
    survey = Factory(:survey, :start_date => Time.now, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    survey.generate_fellow_survey_responses
    survey.reload.survey_responses.size.should == 2
    User.first.survey_responses.size.should == 1
    User.first.surveys.size.should == 1
  end

  it :generate_team_survey_responses do
    2.times {Factory(:team)}
    2.times {Factory(:user)}
    Team.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Team")
    survey.generate_team_survey_responses
    survey.reload.survey_responses.size.should == 4
    Team.first.survey_responses.size.should == 2
  end
  
  it :generate_project_survey_responses do
    2.times {Factory(:project)}
    2.times {Factory(:user)}
    Project.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Project")
    survey.generate_project_survey_responses
    survey.reload.survey_responses.size.should == 4
    Project.first.survey_responses.size.should == 2
  end

  it "generate project survey responses" do
    2.times {Factory(:project)}
    2.times {Factory(:user)}
    Project.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Project")
    survey.generate_survey_responses
    survey.reload.survey_responses.size.should == 4
    Project.first.survey_responses.size.should == 2
  end
  
  it "generate team survey responses" do
    2.times {Factory(:team)}
    2.times {Factory(:user)}
    Team.all.each { |x| x.users << User.all }
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Team")
    survey.generate_survey_responses
    survey.reload.survey_responses.size.should == 4
    Team.first.survey_responses.size.should == 2
  end

  it " generate fellow survey responses" do
    2.times {Factory(:profile, :user_type => "Fellow", :user => Factory(:user))}
    survey = Factory(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    survey.generate_survey_responses
    survey.reload.survey_responses.size.should == 2
    User.first.survey_responses.size.should == 1
    User.first.surveys.size.should == 1
  end

end
