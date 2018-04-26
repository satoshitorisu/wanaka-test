class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :organization
      t.string :active_place
      t.string :level
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
