class Playlist < ApplicationRecord
  has_many :listings, dependent: :destroy
  belongs_to :user
end
