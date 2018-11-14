class Picture < ApplicationRecord
  belongs_to :product
  validates_presence_of :url
  mount_uploader :url, UrlUploader
end
