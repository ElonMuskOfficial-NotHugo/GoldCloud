class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  enum role: { admin: 0, driver: 1, customer: 2 }
  has_many :chats
  has_many :messages
  has_many :orders
  validates :username, presence: true
  validates :address, presence: true
  validates :role, presence: true
end
