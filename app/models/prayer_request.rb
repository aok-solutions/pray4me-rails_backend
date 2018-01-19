class PrayerRequest < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :subject, presence: true
  validates :description, presence: true
end
