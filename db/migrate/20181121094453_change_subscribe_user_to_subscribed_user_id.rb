class ChangeSubscribeUserToSubscribedUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :subscribed_user, :subscribed_user_id
  end
end
