require 'spec_helper'

describe Survey do

  describe "various time differences for surveys with timecop" do

    it "1 week out on 1 week frequency" do
      FactoryGirl.create(:survey, :start_date => Time.now, :end_date => Time.now + 1.month)
       Timecop.freeze(Time.now + 1.weeks) do
        Survey.last.survey_today?.should be_true
      end
    end

    it "15 weeks out on 2 week frequency" do
      FactoryGirl.create(:survey, :start_date => Time.now, :end_date => Time.now + 1.year, :frequency => "2")
      Timecop.freeze(Time.now + 15.weeks) do
        Survey.last.survey_today?.should be_false
      end
    end

  end

  it "should delete expired survey responses where note and response are nil" do
    survey = FactoryGirl.create(:survey)
    sr = FactoryGirl.create(:user_survey_response, :response => 1, :note => nil, :expires_on => 1.week.ago, :survey => survey)
    sr = FactoryGirl.create(:user_survey_response, :note => "something", :response => nil, :expires_on => 1.week.ago, :survey => survey)
    sr = FactoryGirl.create(:user_survey_response, :note => nil, :response => nil, :expires_on => 1.week.ago, :survey => survey)
    SurveyResponse.count.should == 3
    sr.survey.delete_expired_responses
    SurveyResponse.count.should == 2

  end

  it "should return a list of surveys currently active" do
    FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week)
    FactoryGirl.create(:survey, :start_date => 1.month.ago, :end_date => 1.week.ago)
    Survey.active_surveys.size.should == 1
  end

  it :generate_fellow_survey_responses do
    2.times {FactoryGirl.create(:user)}
    survey = FactoryGirl.create(:survey, :start_date => Time.now, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    survey.generate_fellow_survey_responses
    survey.reload.survey_responses.size.should == 2
    User.first.survey_responses.size.should == 1
    User.first.surveys.size.should == 1
  end

  it :generate_team_survey_responses do
    2.times {FactoryGirl.create(:team)}
    2.times {FactoryGirl.create(:user)}
    Team.all.each { |x| x.users << User.all }
    survey = FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Team")
    survey.generate_team_survey_responses
    survey.reload.survey_responses.size.should == 4
    Team.first.survey_responses.size.should == 2
  end

  it :generate_project_survey_responses do
    2.times {FactoryGirl.create(:project)}
    2.times {FactoryGirl.create(:user)}
    Project.all.each { |x| x.users << User.all }
    survey = FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Project")
    survey.generate_project_survey_responses
    survey.reload.survey_responses.size.should == 4
    Project.first.survey_responses.size.should == 2
  end

  it "generate project survey responses" do
    2.times {FactoryGirl.create(:project)}
    2.times {FactoryGirl.create(:user)}
    Project.all.each { |x| x.users << User.all }
    survey = FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Project")
    survey.generate_survey_responses
    survey.reload.survey_responses.size.should == 4
    Project.first.survey_responses.size.should == 2
  end

  it "generate team survey responses" do
    2.times {FactoryGirl.create(:team)}
    2.times {FactoryGirl.create(:user)}
    Team.all.each { |x| x.users << User.all }
    survey = FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Team")
    survey.generate_survey_responses
    survey.reload.survey_responses.size.should == 4
    Team.first.survey_responses.size.should == 2
  end

  it " generate fellow survey responses" do
    2.times {FactoryGirl.create(:profile, :user_type => "Fellow", :user => FactoryGirl.create(:user))}
    survey = FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    survey.generate_survey_responses
    survey.reload.survey_responses.size.should == 2
    User.first.survey_responses.size.should == 1
    User.first.surveys.size.should == 1
  end

  it 'generates a trending by date group average hash' do
    2.times {FactoryGirl.create(:profile, :user_type => "Fellow", :user => FactoryGirl.create(:user))}
    survey1 = FactoryGirl.create(:survey, :start_date => 1.week.ago, :end_date => Time.now + 1.week, :frequency => 1, :survey_type => "Fellow")
    sr1 = FactoryGirl.create(:user_survey_response, :response => 3, :survey => survey1, :user => User.first)
    sr2 = FactoryGirl.create(:user_survey_response, :response => 1, :survey => survey1, :user => User.first)
    sr1.update_attributes(:created_at => 1.week.ago)
    sr2.update_attributes(:created_at => 1.week.ago)
    FactoryGirl.create(:user_survey_response, :response => 1, :survey => survey1, :user => User.first, :created_at => Time.now)
    FactoryGirl.create(:user_survey_response, :response => 1, :survey => survey1, :user => User.first, :created_at => Time.now)
    trends = survey1.reload.survey_responses.trending
    puts trends
    trends.size.should == 2
    trends.first[1].to_f.should == 1.0
    trends.last[1].to_f.should == 2.0
  end

end
