class ChangePictureToPicturesInProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :picture, :pictures
  end
end
