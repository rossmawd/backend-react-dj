class Listing < ApplicationRecord
  belongs_to :playlist
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  validates :url, uniqueness: { scope: :playlist, message: "This song is already in the playlist!"}

end
