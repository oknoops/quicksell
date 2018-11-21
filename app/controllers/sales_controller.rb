class SalesController < ApplicationController
  before_action :set_sale_and_product, only: [:show, :destroy]

  def show
    authorize @sale
  end

  def create
    @sale = Sale.new
    @sale.user = current_user
    @sale.product = Product.find(params[:product_id])
    authorize @sale
    if @sale.save
      flash[:notice] = "Items succesfully bought"
      create_notification(@sale.product)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
      # redirect_to dashboard_path
    else
      flash[:alert] = "You don't have enough money, add some to your wallet"
      redirect_to new_payment_path
    end
  end

  def destroy
    @sale.destroy
  end

  private

  def set_sale_and_product
    @product = Product.find(params[:product_id])
    @sale = Sale.find(params[:id])
    authorize @sale
  end

  def create_notification(product)
      return if product.user.id == current_user.id
    Notification.create(user_id: product.user.id,
                          subscribed_user_id: current_user.id,
                          product_id: product.id,
                          notification_type: 'sale')
  end
end
