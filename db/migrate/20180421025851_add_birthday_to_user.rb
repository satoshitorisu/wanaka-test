class AddBirthdayToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :birth_day, :datetime
    add_column :users, :sex, :boolean
  end
end
