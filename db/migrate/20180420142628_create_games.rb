class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.references :team, foreign_key: true
      t.string :place
      t.string :price
      t.datetime :date_time
      t.string :memo

      t.timestamps
    end
  end
end
