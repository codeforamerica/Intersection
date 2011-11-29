ActiveAdmin.register User do
  form do |f|
  f.inputs "Profile" do
    f.semantic_fields_for :profile do |p|
      p.inputs :name, :user_type
    end
  end
  f.buttons
  end
end
