class ReviewsController < ApplicationController
  before_action :set_sale_and_product, only: [:new, :create, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(params_review)
    @review.sale = Sale.find(params[:sale_id])
    @review.user = current_user
    if @review.save
      redirect_to user_path(@sale.user)
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    redirect_to user_path(@sale.user)
  end

  private

  def params_review
     params.require(:review).permit(:description, :rating)
  end

  def set_sale_and_product
    @sale = Sale.find(params[:sale_id])
    @product = Product.find(params[:product_id])
    authorize @review
  end
end
