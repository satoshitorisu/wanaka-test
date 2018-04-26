class AddTeamIdToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :team, foreign_key: true
  end
end
