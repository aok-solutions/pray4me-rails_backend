class User < ApplicationRecord
  has_many :prayer_requests, dependent: :destroy
end
