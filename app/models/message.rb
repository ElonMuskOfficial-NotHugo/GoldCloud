class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :chat, presence: true
  validates :user, presence: true
  validates :content, presence: true
end
