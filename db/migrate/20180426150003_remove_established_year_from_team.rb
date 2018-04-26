class RemoveEstablishedYearFromTeam < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :established_yaer, :datetime
  end
end
