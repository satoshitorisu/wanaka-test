class AddTeamKeyToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :team_key, :string
  end
end
