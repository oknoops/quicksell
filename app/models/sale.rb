class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :product

  after_create :selling

  validate :selling_ready

  private

  def selling_ready
    if user.wallet_amount < product.price
      errors.add(:user, 'Sorry not enough credit')
    end
  end

  def selling
    user.wallet_amount -= product.price
    user.save
    product.user.wallet_amount += product.price
    product.user.save
    product.status = "pending"
    product.save
  end
end
