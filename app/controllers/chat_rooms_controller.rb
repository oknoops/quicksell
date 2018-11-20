class ChatRoomsController < ApplicationController

  def create
    @product = Product.find(params[:id])
    @chat_room = ChatRoom.new(name: @product)
    authorize @chat_room
    @chat_room.save
    redirect_to chat_room_path(@chat_room)
  end


  def show
    @chat_room = ChatRoom.includes(messages: :user).find(params[:id])
    authorize @chat_room
  end
end
