class RemovePicturesFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :pictures
  end
end
