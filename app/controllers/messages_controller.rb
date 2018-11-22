class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    authorize @message
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message.chat_room = @chat_room
    @message.user = current_user
    if @message.save
    unless User.find(@message.chat_room.sender_id).notifications.any? { |n| n.read == false && n.subscribed_user_id == current_user.id && n.notification_type == "message"}
      create_notification(@message)
    end
      respond_to do |format|
        format.html { redirect_to chat_room_path(@chat_room) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "chat_rooms/show" }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def create_notification(message)
    if message.chat_room.recipient_id == current_user.id
      Notification.create(user_id: message.chat_room.sender_id,
                            subscribed_user_id: current_user.id,
                            product_id: message.chat_room.id,
                            notification_type: 'message')
    else
      Notification.create(user_id: message.chat_room.recipient_id,
                            subscribed_user_id: current_user.id,
                            product_id: message.chat_room.id,
                            notification_type: 'message')
    end
  end
end
