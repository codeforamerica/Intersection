
#--[ User ]---------------------------------------------------------------------
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.admin false
  u.password "something"
  u.after_build do |user|
    user.profile = Factory.create(:profile)
  end
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
