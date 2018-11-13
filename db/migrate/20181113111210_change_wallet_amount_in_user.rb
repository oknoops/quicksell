class ChangeWalletAmountInUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :wallet_amount, :wallet_cents
  end
end
