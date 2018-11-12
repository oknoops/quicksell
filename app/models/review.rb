class Review < ApplicationRecord
  belongs_to :sale
  belongs_to :user
  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5, :message => "Rating needs to be betwen 0 and 5"
end
