class Product < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :picture
  validates_presence_of :pickup_time
  validates_presence_of :pickup_address

  mount_uploader :picture, PictureUploader
end
