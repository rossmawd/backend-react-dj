class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :party, :genre, :user_id, :created_at, :updated_at

  def user
  
    UserSerializer.new(self.object.user)
  end
end
