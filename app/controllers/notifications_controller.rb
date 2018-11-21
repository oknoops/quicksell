class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    if @notification.notification_type == "sale"
      redirect_to product_path(@notification.product)
    else
      redirect_to chat_room_path(@notification.product)
    end
    authorize @notification
  end
end
