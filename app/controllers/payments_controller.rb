class PaymentsController < ApplicationController

  def new
    @amount = Sale.new
    authorize @amount
  end

  def confirm
    @amount = Sale.new
    authorize @amount
  end

  def create
    @amount = Sale.new
    authorize @amount
    @amount = (params[:amount].to_f * 100).to_i
    Stripe::Charge.create(
      source: params[:stripeToken],
      amount: @amount,
      currency: 'eur',
      description: 'Custom donation'
    )
    current_user.wallet += Money.new(@amount)
    current_user.save
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  def retrieve
    @amount = Sale.new
    authorize @amount
  end

  def moneyback
    @amount = Sale.new
    authorize @amount
    @amount = (params[:amount].to_f * 100).to_i
    if current_user.wallet > Money.new(@amount)
      current_user.wallet -= Money.new(@amount)
      current_user.save!
    else
      flash[:alert] = "You don't have enough money"
      render :retrieve
    end
  end

end
