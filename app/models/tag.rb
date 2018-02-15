class Tag < ApplicationRecord
  has_and_belongs_to_many :prayer_requests

  validates :name, presence: true, uniqueness: true
end
