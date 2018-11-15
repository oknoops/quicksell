class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :products
  has_many :sales
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

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
  end
end
