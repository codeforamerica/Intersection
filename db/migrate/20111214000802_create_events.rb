class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :team_id
      t.string :name
      t.integer :attendance
      t.datetime :event_date
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
