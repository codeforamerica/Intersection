class CreateBatchbookLists < ActiveRecord::Migration
  def change
    create_table :batchbook_lists do |t|
      t.integer :team_id
      t.integer :batchbook_id
      t.string :name

      t.timestamps
    end
  end
end
