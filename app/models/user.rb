class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :products
  has_many :sales

  validates_presence_of :first_name, :message => "Don't forget your first name"
  validates_presence_of :last_name, :message => "Don't forget your last name"
end
