class SalesController < ApplicationController
  before_action :set_sale_and_product, only: [:destroy]


  def show
  end

  def create
    @sale = Sale.new
    @sale.user = current_user
    @sale.product = Product.find(params[:product_id])
    if @sale.save
      redirect_to dashboard_path
    else
      render 'product/show'
    end
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
