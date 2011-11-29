ActiveAdmin.register Profile do
   form do |f|
      f.inputs "Details" do
        f.input :user, :collection => User.all.map { |x| [x.email, x.id]}
        f.input :bio
        f.input :name
        f.input :user_type
      end
    end
end
