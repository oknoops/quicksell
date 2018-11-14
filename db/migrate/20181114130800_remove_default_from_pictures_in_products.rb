class RemoveDefaultFromPicturesInProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:products, :pictures, nil)
  end
end
