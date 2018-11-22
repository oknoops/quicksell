class Product < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :price
  validates_numericality_of :price, greater_than_or_equal_to: 0
  # validates_presence_of :picture
  validates_presence_of :pickup_time
  validate :date, on: :create
  validates_presence_of :pickup_address
  has_many :pictures, dependent: :delete_all
  has_many :notifications, dependent: :destroy
  has_one :sale
  monetize :price_cents
  geocoded_by :pickup_address
  after_validation :geocode, if: :will_save_change_to_pickup_address?

  def date
    if pickup_time < Time.now
      errors.add(:pickup_time, "should be in the future")
    end
  end

  def check_date
    if pickup_time < Time.now && status == "pending"
      self.status = "sold"
      self.save!
      create_notification_sold(self)
    elsif pickup_time < Time.now && status == "for-sale"
      self.status = "expired"
      self.save!
      create_notification(self)
    elsif pickup_time > Time.now && status == "expired"
      self.status = "for-sale"
      self.save!
    end
  end

  def category_icon
    case category
    when "Beauty and Wellbeing"
      "fas fa-lips"
    when "Books and Magazine"
      "fas fa-book-open"
    when "Movies and Video Games"
      "fas fa-film"
    when "High-Tech"
      "fas fa-tv"
    when "Toys and Youth"
      "fas fa-child"
    when "House and Pets"
      "fas fa-paw"
    when "Retail"
      "fas fa-shopping-cart"
    when "Clothing and Fashion"
      "fas fa-tshirt"
    when "Sport and Leisure"
      "fas fa-football-ball"
    when "Cars and Mechanics"
      "fas fa-car"
    when "Handmade"
      "fas fa-hand-holding-seedling"
    end
  end

  private

  def create_notification(product)
    Notification.create(user_id: product.user.id,
                          subscribed_user_id: product.user.id,
                          product_id: product.id,
                          notification_type: 'expired')
  end

  def create_notification_sold(product)
    Notification.create(user_id: product.sale.user.id,
                          subscribed_user_id: product.user.id,
                          product_id: product.id,
                          notification_type: 'finish')
  end

end
