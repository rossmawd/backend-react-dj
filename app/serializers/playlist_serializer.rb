class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :party, :genre, :user_id

  def user
  
    UserSerializer.new(self.object.user)
  end
end
