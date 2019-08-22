class Playlist < ApplicationRecord
  has_many :listings, dependent: :destroy
  belongs_to :user


  def update_positions(params)
    listing_id = params['listing']['id']
    current_position = params['listing']['position']

    songs = self.listings
    sorted_songs = songs.sort { |a, b| a.position <=> b.position }
   
    if params['id'] == 'up' && sorted_songs[current_position + 1]
      other_listing = sorted_songs.filter { |listing| listing.position == current_position + 1 }.last

      Listing.update(other_listing.id, position: current_position)
      Listing.update(listing_id, position: current_position + 1)
      updated_playlist = Playlist.find(self.id)
      return updated_playlist
      # render json: updated_playlist, status: :created
    # check for valid move (cannot go above the top, or below bottom)

    elsif params['id'] == 'down' && ((current_position - 1) >= 0)
      # byebug
      other_listing = sorted_songs.filter { |listing| listing.position == current_position - 1 }.last

      Listing.update(other_listing.id, position: current_position)
      Listing.update(listing_id, position: current_position - 1)
      updated_playlist = Playlist.find(self.id)

      # render json: updated_playlist, status: :created
      return updated_playlist

    elsif params['id'] == 'delete' 
       
      top_index=(sorted_songs.length)-1 
      number_to_update = top_index - (current_position )
      x = current_position + 1

      number_to_update.times do  
        to_update = sorted_songs.filter  { |listing| listing.position == x }.last
        Listing.update(to_update.id, position: x-1)
        x += 1
      end
      
      updated_playlist = Playlist.find(self.id)
      return updated_playlist

      # render json: updated_playlist, status: :created

    else
      # render json: { error: "Can't be moved any further!" }
      return {error: "Can't be moved any further!" }
    end
  end

end
