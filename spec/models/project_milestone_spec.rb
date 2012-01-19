require 'spec_helper'

describe ProjectMilestone do
  before do
    @user = Factory(:user)
    $current_user = @user
    @pm = Factory(:project_milestone) 
  end

  it "should create new activity on new milestone" do
    @pm.project.activities.size.should == 2
  end

  it "should create new activity on milestone delete" do
    @pm.destroy
    Activity.count.should == 3
  end
  
  it "should create new activity on planned date change" do
    @pm.update_attributes(:planned_date => 1.week.ago)
    puts Activity.last.activity
    Activity.last.activity.include?(@pm.planned_date_was.strftime('%m-%d-%y')).should be_true
    Activity.last.activity.include?(@pm.planned_date.strftime('%m-%d-%y')).should be_true
  end

  it "should create new activity on completed date" do
    @pm.update_attributes(:completed_date => 1.week.ago)
    Activity.last.activity.include?("completed").should be_true
    Activity.last.activity.include?(@pm.completed_date.strftime('%m-%d-%y')).should be_true
  end

  it "should create new activity on active status change and change other milestones to inactive if true" do
    Factory(:project_milestone, :project => @pm.project, :active => true)
    ProjectMilestone.where(:active => true).size.should == 1
    @pm.update_attributes(:active => true)
    ProjectMilestone.where(:active => true).size.should == 1
    puts Activity.last.activity
    Activity.last.activity.include?("as active").should be_true
  end


end
