
#--[ User ]---------------------------------------------------------------------
FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "email#{n}@test.com" }
    admin false
    password "something"
  end
end


Factory.define :admin_user, :parent => :user do |u|
  u.admin true
end

Factory.define :profile do |profile|
  profile.name { Faker::Name.name }
  profile.bio {Faker::Lorem.sentence(3)}
  profile.user_type "Fellow"
end


#--[Project]-------------

Factory.define :project do |p|
  p.name {Faker::Company.catch_phrase}
  p.description {Faker::Lorem.paragraph}
  p.impact_statement {Faker::Lorem.paragraph}
  p.tag_list {Faker::Lorem.words(4).join(",")}
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

Factory.define :team do |team|
  team.name {Faker::Address.city}
end

#------Surveys---------------

Factory.define :survey do |s|
  s.name {Faker::Company.catch_phrase}
  s.start_date {Time.now}
  s.end_date {Time.now + 8.weeks}
  s.frequency "1.weeks"
  s.survey_type "Project"
  s.scale 6
end

Factory.define :survey_response do |r|
  r.expires_on {Time.now + 1.week}
  r.response 6
  r.note {Faker::Lorem.sentence(2)}
  r.survey {Factory(:survey)}
  r.user {Factory(:user)}
end

Factory.define :user_survey_response, :parent => :survey_response do |u|
  u.surveyable {Factory(:user)}
end

Factory.define :project_survey_response do |u|
  u.surveyable {Factory(:project)}
end

Factory.define :team_survey_response do |u|
  u.surveyable {Factory(:team)}
end

Factory.define :batchbook_list do |l|
  l.team {Factory(:team)}
  l.batchbook_id {rand(100000)}
end

Factory.define :batchbook_list_history do |h|
  h.contact_number {rand(10000)}
  h.batchbook_list {Factory(:batchbook_list)}
end

