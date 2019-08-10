class Dislike < ApplicationRecord
  belongs_to :listing
  belongs_to :user
end
