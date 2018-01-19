class Tagging < ApplicationRecord
  belongs_to :prayer_request
  belongs_to :tag
end
