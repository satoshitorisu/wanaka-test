class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :admin
      t.integer :status
      t.string :greeting

      t.timestamps
    end
  end
end
