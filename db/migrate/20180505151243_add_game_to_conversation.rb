class AddGameToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :game, :integer
  end
end
