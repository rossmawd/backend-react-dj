class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :party, :genre, :user_id, :created_at, :updated_at, :listings

  def listings 
    self.object.listings.map { |l|ListingSerializer.new(l) }
  end

  def user
    UserSerializer.new(self.object.user)
  end

end
