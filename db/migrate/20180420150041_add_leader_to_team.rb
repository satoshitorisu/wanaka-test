class AddLeaderToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :leader, :string
  end
end
