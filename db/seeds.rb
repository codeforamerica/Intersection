require 'factory_girl'
require 'faker'
require 'factory_girl_rails'

if Rails.env!='production'

#Add User Types
  staff = Factory(:user_type, :name => "Staff")
  fellow = Factory(:user_type, :name => "Fellow")

#Add Fellows
  puts "Adding 15 Fellows"
    15.times do |i|
      user = Factory(:user)
    end

#Add Admin
  puts "Creating admin"
  user = Factory(:admin_user)
  user_type = UserType.last
  user_type.name = "Staff"
  user_type.save
  puts "\t Admin #{user.email} pass something\n"

#Adding Projects
  puts "Adding projects with random start dates over the last six months"
  50.times {
    project = Factory(:project)
    project.update_attributes(:created_at => rand(5).months.ago + rand(10).days)
    5.times {Factory(:link, :project => project)}
  }

end


