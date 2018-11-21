class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  monetize :wallet_cents
  mount_uploader :profile_picture, ProfilePictureUploader
  validates_presence_of :first_name, :message => "Don't forget your first name"
  validates_presence_of :last_name, :message => "Don't forget your last name"
  validates_presence_of :address, :message => "Don't forget your address"

  def average
    total = []
    products.each do |product|
      total << product.sale.review.rating if product.sale && product.sale.review
    end
    if total.size.zero?
      return 0
    else
      return total.sum / total.size
    end
  end

  def level_up?
    if (sales.count / level > 10) || (products.count / level > 5)
      self.level += 1
      self.wallet += Money.new(2000)
      self.save!
      return true
    else
      return false
    end
  end

  # after_create :send_welcome_email

  # private

  #   def send_welcome_email
  #     UserMailer.welcome(self).deliver_now
  #   end
  end
