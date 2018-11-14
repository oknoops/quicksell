class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present? && params[:category].present?
      @products = policy_scope(Product).joins(:user).where("products.category like ? AND (products.name @@ ? OR products.description @@ ? OR users.last_name @@ ?)", params[:category], params[:query], params[:query], params[:query], params[:query], params[:query])
    elsif params[:query].present?
      @products = policy_scope(Product).joins(:user).where("products.name @@ ? OR products.description @@ ? OR users.first_name @@ ? OR users.last_name @@ ?", params[:query], params[:query], params[:query], params[:query])
    elsif params[:category].present?
      @products = policy_scope(Product).joins(:user).where("products.category ilike ?", params[:category])
    else
      @products = policy_scope(Product)
    end
  end

  def show
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @photo1 = params[:product][:pictures][0]
    @photo2 = params[:product][:pictures][0]
    authorize @product
    if @product.save
      raise
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to user_path(current_user)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :pickup_time, :pickup_address, :category, :pictures => [])
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
