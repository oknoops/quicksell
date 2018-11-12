class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def dashboard
  end

  private

  def average(user)
    total = []
    user.sales.each do |sale|
      total << sale.review.rating
    end
    if total.size.zero?
      return 0
    else
      return total.sum / total.size
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_picture, :phone_number, :address, :level)
  end
end
