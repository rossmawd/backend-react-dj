class Listing < ApplicationRecord
  belongs_to :playlist
  has_many :likes
  has_many :dislikes
end
