class CreateProjectMilestones < ActiveRecord::Migration
  def change
    create_table :project_milestones do |t|
      t.integer :project_id
      t.integer :milestone_id
      t.date :planned_date
      t.boolean :active, :default => false

      t.timestamps
    end
  end
end
