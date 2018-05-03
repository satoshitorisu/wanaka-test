class RemoveStartTimeFromSchedule < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :start_time, :datetime
    remove_column :schedules, :end_time, :datetime
  end
end
