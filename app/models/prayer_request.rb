class PrayerRequest < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :tags

  validates :subject, presence: true
  validates :description, presence: true
end
