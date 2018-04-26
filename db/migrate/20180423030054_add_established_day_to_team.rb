class AddEstablishedDayToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :established_year, :datetime
  end
end
