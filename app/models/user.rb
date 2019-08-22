class User < ApplicationRecord
  has_secure_password
  has_many :playlists, dependant: :destroy
  has_many :likes, dependant: :destroy
  has_many :dislikes, dependant: :destroy
  has_many :listings, through: :playlists
end
