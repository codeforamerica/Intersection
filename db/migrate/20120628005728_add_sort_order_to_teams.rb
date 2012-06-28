class AddSortOrderToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sort_order, :integer
  end
end
