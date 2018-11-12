class ChangeUserTableDefaultValues < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :wallet_amount, 50
    change_column :users, :wallet_amount, :integer
    change_column_default :users, :level, 1
  end
end
