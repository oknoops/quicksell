class AddPaymentToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :payment, :jsonb
  end
end
