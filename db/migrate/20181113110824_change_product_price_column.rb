class ChangeProductPriceColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :price, :price_cents
  end
end
