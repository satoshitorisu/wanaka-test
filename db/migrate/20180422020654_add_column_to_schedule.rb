class AddColumnToSchedule < ActiveRecord::Migration[5.2]
  def change
	add_column :schedules, :start_time, :datetime
	add_column :schedules, :end_time, :datetime
	remove_column :schedules, :date_time, :datetime
  end
end
