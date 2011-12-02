class CreateTeamProjects < ActiveRecord::Migration
  def change
    create_table :team_projects do |t|
      t.integer :project_id
      t.integer :team_id

      t.timestamps
    end
  end
end
