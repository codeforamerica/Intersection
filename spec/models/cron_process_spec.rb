require 'spec_helper'

describe CronProcess do

  describe "Create Surveys" do
    before do
      2.times {FactoryGirl.create(:team)}
      2.times {FactoryGirl.create(:user)}
      2.times {FactoryGirl.create(:project)}
      Team.all.each {|x| x.users << User.all}
      Project.all.each {|x| x.users << User.all}
    end

    it "should create one fellow, project and team survey" do
      FactoryGirl.create(:survey, :frequency => 1, :survey_type => "Fellow", :start_date => Time.now, :end_date =>Time.now + 1.month)
      FactoryGirl.create(:survey, :frequency => 1,:survey_type => "Team", :start_date => Time.now, :end_date =>Time.now + 1.month)
      FactoryGirl.create(:survey, :frequency => 1,:survey_type => "Project", :start_date => Time.now, :end_date =>Time.now + 1.month)
      CronProcess.new.generate_survey_responses
      SurveyResponse.count.should == 10
      #ensure that this doesn't generate duplicates
      CronProcess.new.generate_survey_responses
      SurveyResponse.count.should == 10

    end
  end

end
