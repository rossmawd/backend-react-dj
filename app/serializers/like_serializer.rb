class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :listing_id

  def listing
    ListingSerializer.new(self.object.listing)
  end

  def user
    UserSerializer.new(self.object.user)
  end

end
