class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :team_id
      t.text :story

      t.timestamps
    end
  end
end
