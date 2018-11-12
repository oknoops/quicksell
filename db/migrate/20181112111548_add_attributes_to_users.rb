class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_column :users, :level, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :profile_description, :text
    add_column :users, :profile_picture, :string
    add_column :users, :wallet_amount, :float
  end
end
