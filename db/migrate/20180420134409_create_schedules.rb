class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :title
      t.string :place
      t.datetime :date_time
      t.string :memo

      t.timestamps
    end
  end
end
