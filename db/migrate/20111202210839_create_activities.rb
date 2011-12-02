class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :team_id
      t.integer :user_id
      t.integer :project_id
      t.text :activity

      t.timestamps
    end
  end
end
