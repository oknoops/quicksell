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
    authorize @user
  end

  def dashboard
    @chat_rooms = ChatRoom.all
    current_user.products.each { |p|  p.check_date }
    if current_user.level_up?
      flash[:notice] = "Congrats, you leveled up. Here are 20 €"
    end
    authorize current_user
  end

  def add_money
    if current_user.wallet.nil?
      current_user.wallet = Money.new(5000)
    else
      current_user.wallet += Money.new(5000)
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
