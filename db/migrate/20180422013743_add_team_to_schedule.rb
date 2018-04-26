class AddTeamToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_reference :schedules, :team, foreign_key: true
  end
end
