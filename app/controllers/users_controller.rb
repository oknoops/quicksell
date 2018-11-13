class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = policy_scope(User).order(created_at: :desc)
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
    authorize @users
  end

  def dashboard
    authorize current_user
  end

  def add_money
    if current_user.wallet_amount.nil?
      current_user.wallet_amount = 50
    else
      current_user.wallet_amount += 50
    end
    current_user.save
    redirect_to dashboard_path
    authorize current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_description, :profile_picture, :address, :phone_number)
  end
end
