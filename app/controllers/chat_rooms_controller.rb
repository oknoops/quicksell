class ChatRoomsController < ApplicationController
  def index
    @users = policy_scope(User)
    @chat_rooms = policy_scope(ChatRoom)
  end

  def create
    if ChatRoom.between(chat_room_params[:sender_id], chat_room_params[:recipient_id]).present?
      @chat_room = ChatRoom.between(chat_room_params[:sender_id], chat_room_params[:recipient_id]).first
    else
      @chat_room = ChatRoom.create!(chat_room_params)
    end
    authorize @chat_room
    redirect_to chat_room_path(@chat_room)
  end

  def show
    @chat_room = ChatRoom.includes(messages: :user).find(params[:id])
    authorize @chat_room
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:sender_id, :recipient_id)
  end
end

