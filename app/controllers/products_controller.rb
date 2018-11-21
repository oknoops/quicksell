class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  helper_method :sort_direction

  def index
    @chat_room = ChatRoom.first
    if params[:km].present? && params[:category].present?
      @products = policy_scope(Product).joins(:user).where("products.category ilike ?", params[:category]).near(current_user.address, params[:km])
    elsif params[:km].present?
      @products = policy_scope(Product).near(current_user.address, params[:km])
    elsif params[:category].present?
      @products = policy_scope(Product).joins(:user).where("products.category ilike ?", params[:category])
    else
      @products = policy_scope(Product)
    end

    case params[:sort]
    when "Name"
      @products = @products.order("name ASC")
    when "Rating"
      @products = @products.sort_by { |product| product.user.average }.reverse!
    when "Distance"
      @products = @products.sort_by { |product| product.distance_from(current_user.address) }
    when "Price Ascending"
      @products = @products.order("price_cents ASC")
    when "Price Descending"
      @products = @products.order("price_cents DESC")
    end
  end

  def search
    @products = policy_scope(Product).joins(:user).where("products.name @@ ? OR products.description @@ ? OR users.first_name @@ ? OR users.last_name @@ ?", params[:query], params[:query], params[:query], params[:query])
    authorize @products
  end

  def show
    @chat_room = ChatRoom.new
    @picture = Picture.new
    unless @product.longitude.nil?
      @markers = [{
        lng: @product.longitude,
        lat: @product.latitude
      }]
    end
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product
    if @product.save
      redirect_to new_product_picture_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      @product.check_date
      @product.save!
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to dashboard_path
  end


  private

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :pickup_time, :pickup_address, :category)
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
