class Api::V1::PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    render json: @playlists, status: :ok
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.valid?
      @playlist.save                                           # status 201: creted
      render json: { playlist: PlaylistSerializer.new(@playlist) }, status: :created
    else
      render json: { errors: @playlist.errors.full_messages }, status: :not_accepted
    end
  end

  def destroy
    @playlist = Playlist.where(id: params[:id]).first
    if @contact.destroy
      head[:ok]
      render json: { message: "Playlist Successfully Deleted" }
    else
      head(:unprocessable_entity)
      render json: { error: "Delete Unsuccessful" }
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :party, :genre, :user_id)
  end
end
