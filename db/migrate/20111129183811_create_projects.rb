class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.text :impact_statement
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
