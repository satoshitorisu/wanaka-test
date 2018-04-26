class CreateParticipates < ActiveRecord::Migration[5.2]
  def change
    create_table :participates do |t|
      t.references :schedule, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status
      t.string :memo

      t.timestamps
    end
  end
end
