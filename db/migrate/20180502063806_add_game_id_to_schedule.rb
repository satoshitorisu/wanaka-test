class AddGameIdToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :schedule_id, :integer
  end
end
