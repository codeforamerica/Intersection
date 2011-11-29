
#--[ User ]---------------------------------------------------------------------
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.admin false
  u.password "something"
  u.profile {Factory(:profile)}
end

Factory.define :admin_user, :parent => :user do |u|
  u.admin true
end

Factory.define :profile do |profile|
  profile.name { Faker::Name.name }
  profile.bio {Faker::Lorem.sentence(3)}
  profile.user_type {Factory(:user_type)}
end

Factory.define :user_type do |ut|
  ut.name "Fellow"
end

#--[Project]-------------

Factory.define :project do |p|
  p.name {Faker::Company.catch_phrase}
  p.description {Faker::Lorem.sentence(3)}
  p.impact_statement {Faker::Lorem.sentence(3)}
end
