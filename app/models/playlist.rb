class Playlist < ApplicationRecord
  has_many :listings, dependant: :destroy
  belongs_to :user
end
