class ListingSerializer < ActiveModel::Serializer
  attributes :id, :playlist_id, :url,:suggestion, :position, :name, :dislikes, :likes

end
