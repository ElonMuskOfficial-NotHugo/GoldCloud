class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages

  validates :title, presence: true
  validates :user, presence: true
end
