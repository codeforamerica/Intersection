class AddUserTypeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_type, :integer
  end
end
