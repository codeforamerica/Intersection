class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :link
      t.integer :project_id
      t.integer :link_type_id

      t.timestamps
    end
  end
end
