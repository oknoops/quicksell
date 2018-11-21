class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subscribed_user, :foreign_key => :subscribed_user_id, class_name: 'User'
  belongs_to :product

  validates :user_id, :subscribed_user_id, :product_id, :notification_type, presence: true
end
