class RemoveUserFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_reference :games, :user, foreign_key: true
  end
end
