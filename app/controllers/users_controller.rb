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

  def add_money
    if current_user.wallet_amount.nil?
      current_user.wallet_amount = 50
    else
      current_user.wallet_amount += 50
    end
    current_user.save
    redirect_to dashboard_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_description, :profile_picture, :address, :phone_number)
  end
end
