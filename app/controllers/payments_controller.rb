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
    @amount = params[:amount]
    Stripe::Charge.create(
      source: params[:stripeToken],
      amount: @amount,
      currency: 'eur',
      description: 'Custom donation'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
    current_user.wallet += @amount
    current_user.save
    redirect_to new_payment_path
  end
end
