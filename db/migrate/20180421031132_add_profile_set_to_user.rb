class AddProfileSetToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_set, :boolean
  end
end
