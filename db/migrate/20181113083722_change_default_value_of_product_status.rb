class ChangeDefaultValueOfProductStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :products, :status, "for-sale"
  end
end
