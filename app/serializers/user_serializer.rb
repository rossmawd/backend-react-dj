class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :playlists

  def playlists
    self.object.playlists.map { |p| PlaylistSerializer.new(p) }
  end
end
