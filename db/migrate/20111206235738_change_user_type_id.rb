class ChangeUserTypeId < ActiveRecord::Migration
  def up
  remove_column :profiles, :user_type_id
  add_column :profiles, :user_type, :string
  end

  def down
    remove_column :profiles, :user_type
    add_column :profiles, :user_type_id, :integer
  end
end
