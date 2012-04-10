
#--[ User ]---------------------------------------------------------------------
FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "email#{n}@test.com" }
    admin false
    password "something"
  end

  factory  :admin_user, :parent => :user do |u|
    u.admin true
  end

  factory :profile do |profile|
    profile.name { Faker::Name.name }
    profile.bio {Faker::Lorem.sentence(3)}
    profile.user_type "Fellow"
  end


#--[Project]-------------

  factory :project do |p|
    p.name {Faker::Company.catch_phrase}
    p.description {Faker::Lorem.paragraph}
    p.impact_statement {Faker::Lorem.paragraph}
    p.tag_list {Faker::Lorem.words(4).join(",")}
  end

  factory :link_type do |lt|
    lt.name "github"
  end

  factory :link do |l|
    l.name "Something"
    l.url {Faker::Internet.domain_name}
    l.project {FactoryGirl.create(:project)}
    l.link_type {FactoryGirl.create(:link_type)}
  end


  factory :milestone do |m|
    m.name {Faker::Lorem.words(4).to_sentence}
  end

  factory :project_milestone do |pm|
    pm.milestone {FactoryGirl.create(:milestone)}
    pm.project {FactoryGirl.create(:project)}
    pm.planned_date {rand(6).months.ago}
  end

#----Teams--------

  factory :team do |team|
    team.name {Faker::Address.city}
  end

  factory :event do |e|
    e.team {FactoryGirl.create(:team)}
    e.name {Faker::Lorem.sentence}
    e.attendance {rand(200)}
    e.event_date {rand(15).weeks.ago}
    e.url {Faker::Internet.domain_name}
    e.description {Faker::Lorem.paragraph}
  end

#------Surveys---------------

  factory :survey do |s|
    s.name {Faker::Company.catch_phrase}
    s.start_date {Time.now}
    s.end_date {Time.now + 8.weeks}
    s.frequency "1.weeks"
    s.survey_type "Project"
    s.scale 6
  end

  factory :survey_response do |r|
    r.expires_on {Time.now + 1.week}
    r.response 6
    r.note {Faker::Lorem.sentence(2)}
    r.survey {FactoryGirl.create(:survey)}
    r.user {FactoryGirl.create(:user)}
  end

  factory :user_survey_response, :parent => :survey_response do |u|
    u.surveyable {FactoryGirl.create(:user)}
  end

  factory :project_survey_response do |u|
    u.surveyable {FactoryGirl.create(:project)}
  end

  factory :team_survey_response do |u|
    u.surveyable {FactoryGirl.create(:team)}
  end

  factory :batchbook_list do |l|
    l.team {FactoryGirl.create(:team)}
    l.batchbook_id {rand(100000)}
  end

  factory :batchbook_list_history do |h|
    h.contact_number {rand(10000)}
    h.batchbook_list {FactoryGirl.create(:batchbook_list)}
  end

  factory :story do |s|
    s.user {FactoryGirl.create(:user)}
    s.story {Faker::Lorem.paragraphs(2)}
  end
end
