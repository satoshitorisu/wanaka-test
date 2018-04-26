class RemoveTeamIdFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :team_id, :integer
  end
end
