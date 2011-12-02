class CreateTeamUsers < ActiveRecord::Migration
  def change
    create_table :team_users do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
