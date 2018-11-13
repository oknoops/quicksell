class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :products
  has_many :sales
  mount_uploader :profile_picture, ProfilePictureUploader
  validates_presence_of :first_name, :message => "Don't forget your first name"
  validates_presence_of :last_name, :message => "Don't forget your last name"

  def average
    total = []
    reviews.each do |review|
      total << review.rating
    end
    if total.size.zero?
      return 0
    else
      return total.sum / total.size
    end
  end
end
