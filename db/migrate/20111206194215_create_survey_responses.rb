class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.integer :survey_id
      t.integer :response
      t.text :note
      t.integer :user_id
      t.date :expires_on
      t.string :surveyable_type
      t.integer :surveyable_id

      t.timestamps
    end
  end
end
