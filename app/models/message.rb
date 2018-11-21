class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user
  validates_presence_of :content
  after_create :broadcast_message

  def from?(some_user)
    user == some_user
  end

  def broadcast_message
    ActionCable.server.broadcast("chat_room_#{chat_room.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/message",
        locals: { message: self, user_is_messages_author: false }
      ),
      current_user_id: user.id
    })
  end

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

end
