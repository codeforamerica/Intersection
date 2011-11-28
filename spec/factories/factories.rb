
#--[ User ]---------------------------------------------------------------------
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.admin false
  u.password "something"
  # u.after_build do |user|
  # end
end

Factory.define :admin_user, :parent => :user do |u|
  u.admin true
end
