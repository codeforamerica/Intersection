class AddUserTypeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_type_id, :integer
  end
end
