class AddLatitudeAndLongitudeToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :latitude, :float
    add_column :games, :longitude, :float
  end
end
