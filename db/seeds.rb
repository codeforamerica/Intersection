require 'factory_girl'
require 'faker'
require 'factory_girl_rails'

if Rails.env!='production'

#Add User Types
  staff = Factory(:user_type, :name => "Staff")
  fellow = Factory(:user_type, :name => "Fellow")

#Add Fellows
  puts "Adding 24 Fellows"
    24.times do |i|
      user = Factory(:user)
    end

#Add Admin
  puts "Creating admin"
  user = Factory(:admin_user)
  user_type = UserType.last
  user_type.name = "Staff"
  user_type.save
  puts "\t Admin #{user.email} pass something\n"

#Adding Teams
  puts "Adding teams and 3 users per team"
  users = User.all
  8.times {
    team = Factory(:team)
    team.users <<  users.shift(3)
  }
  
#Adding Projects
  puts "Adding projects with random start dates over the last six months and random teams"
  teams = Team.all
  50.times {
    project = Factory(:project)
    project.update_attributes(:created_at => rand(8).months.ago + rand(10).days)
    5.times {Factory(:link, :project => project)}
    teams.shuffle.first.projects << project
  }

  puts "Adding milestones with completion dates"
  5.times { Factory(:milestone) }
  milestones = Milestone.all
  Project.order(:created_at => "ASC").each do |project|
    #look at the project created date and grab total number of months
    months = ((Time.now - project.created_at)/2592000).round
    #check to see if the months are greater than milestones
    if months > milestones.size
    #if so, then add each milestone 
      milestones.each do |milestone|
        planned_date = project.created_at + (milestone.id).months + rand(15).days
    
        #randomly add 1 week difference between completed and planned
        completed_date = rand(2)==1 ? planned_date + rand(8).days : planned_date
    
        #make the last one active
        active = milestones.last==milestone ? true : false
        
        #add the milestone
        ProjectMilestone.create(:project => project, :milestone => milestone, :planned_date => planned_date,:completed_date => completed_date, :active => active)
      end
    else
    #if not, add milestones, but only with completed dates less than current time
     i=0 
      milestones.each do |milestone|
        planned_date = project.created_at + (milestone.id).months + rand(15).days
    
        #if the planned date is less than current date, randomly add 1 week difference between completed and planned
        if planned_date < Time.now
          completed_date = rand(2)==1 ? planned_date + rand(8).days : planned_date
          active = false
        else
          i==1 ? active = false : active = true
          i=1
          completed_date = nil
        end
        #add the milestone
        ProjectMilestone.create(:project => project, :milestone => milestone, :planned_date => planned_date,:completed_date => completed_date, :active => active)
      end
    end
  end

end


