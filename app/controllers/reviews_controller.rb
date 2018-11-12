class ReviewsController < ApplicationController
  before_action :set_sale_and_review, only: [:create, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(params_review)
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

  def set_sale_and_review
    @sale = Sale.find(params[:sale_id])
  end

end
