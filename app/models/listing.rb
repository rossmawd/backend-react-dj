class Listing < ApplicationRecord
  belongs_to :playlist
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  

end
