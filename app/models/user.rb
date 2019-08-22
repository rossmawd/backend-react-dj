class User < ApplicationRecord
  has_secure_password
  has_many :playlists, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :listings, through: :playlists
end
