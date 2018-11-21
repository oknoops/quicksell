class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :subscribed_user
      t.references :product, foreign_key: true
      t.string :type
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
