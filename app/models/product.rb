class Product < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :price
  validates_numericality_of :price, greater_than_or_equal_to: 0
  # validates_presence_of :picture
  validates_presence_of :pickup_time
  validates_presence_of :pickup_address
  has_many :pictures, dependent: :delete_all
  has_one :sale
  monetize :price_cents
  geocoded_by :pickup_address
  after_validation :geocode, if: :will_save_change_to_pickup_address?
end
