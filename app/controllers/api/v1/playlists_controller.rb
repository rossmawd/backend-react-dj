class Api::V1::PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    render json: @playlists, status: :ok
  end

  def create
    @playlist = Playlist.new(playlist_params)

    @playlist.save
    render json: @playlist, status: :created
    # status 201: creted
  end

  def destroy
    @playlist = Playlist.where(id: params[:id]).first
    if @contact.destroy
      head[:ok]
    else
      head(:unprocessable_entity)
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :party, :genre, :user_id)
  end
end
