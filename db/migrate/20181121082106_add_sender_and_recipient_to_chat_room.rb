class AddSenderAndRecipientToChatRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_rooms, :sender_id, :integer
    add_column :chat_rooms, :recipient_id, :integer
  end
end
