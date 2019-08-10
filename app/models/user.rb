class User < ApplicationRecord
  has_secure_password
  has_many :playlists
  has_many :likes
  has_many :dislikes
  has_many :listings, through: :playlists
end
