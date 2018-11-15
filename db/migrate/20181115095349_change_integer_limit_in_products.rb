class ChangeIntegerLimitInProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :price_cents, :integer, limit: 8
  end
end
