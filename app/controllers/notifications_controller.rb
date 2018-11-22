class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    if @notification.notification_type == "sale"
      redirect_to product_path(@notification.product)
    elsif @notification.notification_type == "message"
      redirect_to chat_room_path(@notification.product)
    elsif @notification.notification_type == "expired"
      redirect_to edit_product_path(@notification.product)
    else @notification.notification_type == "finish"
      redirect_to new_product_sale_review_path(@notification.product, @notification.product.sale)
    end
    authorize @notification
  end
end
