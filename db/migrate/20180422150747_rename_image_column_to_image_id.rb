class RenameImageColumnToImageId < ActiveRecord::Migration[5.2]
  def change
  	# rename_column :users, :image_id, :image
  	remove_column :users, :image, :string
  end
end
