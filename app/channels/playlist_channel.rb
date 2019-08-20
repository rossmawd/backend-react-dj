class PlaylistChannel < ApplicationCable::Channel
  def subscribed #what happens when someone loads the relevant line page
    # stream_from "some_channel"
    @playlist = Playlist.find_by(id: params[:playlist_id])
    #We find a playlist with id that matches one passed in by params[:room]
    stream_for @playlist
  end

  def received(data)  #called when our channel receives new data
    PlaylistChannel.broadcast_to(@playlist, {playlist: @playlist, listings:
    @playlist.listings}) 
    # first argument which "room" we would like to broadcast the updates,
    #second argument is whatever data to broadcasr
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
