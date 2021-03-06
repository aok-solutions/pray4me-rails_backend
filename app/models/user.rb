class User < ApplicationRecord
  has_many :prayer_requests, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
end
