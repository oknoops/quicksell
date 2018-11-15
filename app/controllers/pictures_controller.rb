class PicturesController < ApplicationController
  def new
    @picture = Picture.new
    @product = Product.find(params[:product_id])
    authorize @picture
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.product = Product.find(params[:product_id])
    authorize @picture
    if @picture.save
      redirect_to product_path(@picture.product)
    else
      redirect_to product_path(@picture.product)
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @picture = Picture.find(params[:id])
    @picture.destroy
    authorize @picture
    redirect_to product_path(@product)
  end

  private

  def picture_params
    params.require(:picture).permit(:url, :url_cache)
  end
end
