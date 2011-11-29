require 'factory_girl'
require 'faker'
require 'factory_girl_rails'

if Rails.env!='production'


#Add 50 Users
  puts "Creating 30 users"
  30.times do |i|
    user = Factory(:user)
  end
  puts "Adding admins"
  User.all[5..10].each do |user|
    puts "\t Admin #{user.email} pass something\n"
    user.admin = true
    user.save
  end


end
