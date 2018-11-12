class SalesController < ApplicationController
  before_action :set_sale_and_product, only: [:create, :destroy]


  def show
  end

  def create
    @sale = Sale.new
    @sale.user = current_user
    @sale.product = Product.find(params[:product_id])
    redirect_to
  end

  def destroy
    @sale.destroy
  end

  private

  def set_sale_and_product
    @product = Product.find(params[:product_id])
    @sale = Sale.find(params[:id])
  end

end
