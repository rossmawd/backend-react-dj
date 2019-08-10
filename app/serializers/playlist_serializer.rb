class PlaylistSerializer < ActiveModel::Serializer
  attributes :id

  def user
  
    UserSerializer.new(self.object.user)
  end
end
