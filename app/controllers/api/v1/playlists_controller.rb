class Api::V1::PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    render json: @playlists, status: :ok
  end

  def create
    @playlist = Playlist.new(playlist_params)

    if @playlist.valid?
      @playlist.save
      PlaylistChannel.broadcast_to(@playlist, { playlist: @playlist, listings: @playlist.listings })                                     # status 201: creted
      render json: { playlist: PlaylistSerializer.new(@playlist) }, status: :created
    else
      render json: { errors: @playlist.errors.full_messages }, status: :not_accepted
    end
  end

  def update
    playlist = Playlist.find(params[:id])
    if playlist
      playlist.update(playlist_params)
      PlaylistChannel.broadcast_to(playlist, { playlist: playlist, listings: playlist.listings })
      render json: { playlist: PlaylistSerializer.new(playlist) }, status: :created
    else
      render json: { error: "Update Unsuccessful" }
    end
  end

  def show
    playlist = Playlist.find(params[:id])
    render json: playlist, status: :created
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    if @playlist.destroy
      PlaylistChannel.broadcast_to(playlist, { playlist: playlist, listings: playlist.listings })
      render json: { message: "Playlist Successfully Deleted" }, status: :accepted
    else
      render json: { error: "Delete Unsuccessful" }, status: :bad_request
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :party, :genre, :user_id)
  end
end
