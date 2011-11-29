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
      user = Factory(:user, :profile => Factory(:profile, :user_type => fellow))
    end

#Add Admin
  puts "Creating admin"
  user = Factory(:admin_user, :profile => Factory(:profile, :user_type => staff))
  puts "\t Admin #{user.email} pass something\n"

end
