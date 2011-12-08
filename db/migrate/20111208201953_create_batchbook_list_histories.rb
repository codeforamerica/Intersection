class CreateBatchbookListHistories < ActiveRecord::Migration
  def change
    create_table :batchbook_list_histories do |t|
      t.integer :batchbook_list_id
      t.integer :contact_number

      t.timestamps
    end
  end
end
