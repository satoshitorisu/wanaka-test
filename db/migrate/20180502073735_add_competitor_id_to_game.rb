class AddCompetitorIdToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :competiter_id, :integer
  end
end
