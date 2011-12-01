
#--[ User ]---------------------------------------------------------------------
FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "email#{n}@test.com" }
    admin false
    password "something"
    after_build do |user|
      user.profile = Factory.create(:profile)
    end
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

#--[Project]-------------

Factory.define :project do |p|
  p.name {Faker::Company.catch_phrase}
  p.description {Faker::Lorem.sentence(3)}
  p.impact_statement {Faker::Lorem.sentence(3)}
end

Factory.define :link_type do |lt|
  lt.name "github"
end

Factory.define :link do |l|
  l.name "Something"
  l.url {Faker::Internet.domain_name}
  l.project {Factory(:project)}
  l.link_type {Factory(:link_type)}
end


Factory.define :milestone do |m|
  m.name {Faker::Lorem.words(4).to_sentence}
end

Factory.define :project_milestone do |pm|
  pm.milestone {Factory(:milestone)}
  pm.project {Factory(:project)}
  pm.planned_date {rand(6).months.ago}
end
