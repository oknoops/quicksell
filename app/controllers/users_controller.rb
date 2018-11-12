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
      current_user.save
    else
      current_user.wallet_amount += 50
      current_user.save

    end
    redirect_to dashboard_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


end
