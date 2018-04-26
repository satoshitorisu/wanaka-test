class ChangeDatatypeEstablishedYearOfTeams < ActiveRecord::Migration[5.2]
  def change
  	change_column :teams, :established_year, :integer
  end
end
