class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :survey_type
      t.integer :scale
      t.date :start_date
      t.date :end_date
      t.integer :frequency

      t.timestamps
    end
  end
end
