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
    @amount = params[:amount]

    @amount = @amount.gsub('€', '').gsub(',', '')

    begin
      @amount = Float(@amount).round(2)
    rescue
      flash[:error] = 'payment not completed. Please enter a valid amount in USD ($).'
      redirect_to new_payment_path
      return
    end

    @amount = (@amount * 100).to_i # Must be an integer!

    if @amount < 500
      flash[:error] = 'payment not completed. Donation amount must be at least $5.'
      redirect_to new_payment_path
      return
    end

    Stripe::Charge.create(
      source: params[:stripeToken],
      amount: @amount,
      currency: 'usd',
      description: 'Custom donation'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
      current_user.wallet += @amount
      current_user.save
  end
end
