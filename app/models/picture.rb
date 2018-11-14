class Picture < ApplicationRecord
  belongs_to :product
  mount_uploader :url, UrlUploader
end
