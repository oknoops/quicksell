class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :review

  after_create :selling

  validate :selling_ready

  private

  def selling_ready
    if user.wallet_cents < product.price_cents
      errors.add(:user, 'Sorry not enough credit')
    end
  end

  def selling
    user.wallet_cents -= product.price_cents
    user.save
    product.user.wallet_cents += product.price_cents
    product.user.save
    product.status = "pending"
    product.save
  end
end
