class Api::V1::ListingsController < ApplicationController
  

  def index
    listings = Listing.all

    render json: listings
  end

  def create
    listing = Listing.create(listing_params)

    if listing.valid?
      render json: { listing: ListingSerializer.new(listing) }, status: :created
    else
      render json: { errors: listing.errors.full_messages }, status: :not_accepted
    end
  end

  def update
    # listing = current_flatmate.listings.select { |listing| listing.id === params[:id] }

    listing = Listing.find(params[:id])
    if listing
      listing.update(listing_params)
      render json: { listing: ListingSerializer.new(listing) }, status: :created
    else
      render json: { error: 'Update Unsuccessful' }
    end
  end

  def update_position
    
    listing_id = params['listing']['id']
    current_position = params['listing']['position']

    playlist = Playlist.find(params['listing']['playlist_id'])
    songs = playlist.listings
    sorted_songs = songs.sort { |a, b| a.position <=> b.position }
   
    if params['id'] == 'up' && sorted_songs[current_position + 1]
      other_listing = sorted_songs.filter { |listing| listing.position == current_position + 1 }.last

      Listing.update(other_listing.id, position: current_position)
      Listing.update(listing_id, position: current_position + 1)
      updated_playlist = Playlist.find(playlist.id)

      render json: updated_playlist, status: :created
    # check for valid move (cannot go above the top, or below bottom)

    elsif params['id'] == 'down' && ((current_position - 1) >= 0)
      # byebug
      other_listing = sorted_songs.filter { |listing| listing.position == current_position - 1 }.last

      Listing.update(other_listing.id, position: current_position)
      Listing.update(listing_id, position: current_position - 1)
      updated_playlist = Playlist.find(playlist.id)

      render json: updated_playlist, status: :created

    elsif params['id'] == 'delete' 
       
      top_index=(sorted_songs.length)-1 
      number_to_update = top_index - (current_position )
      x = current_position + 1

      number_to_update.times do  
        to_update = sorted_songs.filter  { |listing| listing.position == x }.last
        Listing.update(to_update.id, position: x-1)
        x += 1
      end
      
      updated_playlist = Playlist.find(playlist.id)

      render json: updated_playlist, status: :created

    else
      render json: { error: "Can't be moved any further!" }
    end
  end

  def destroy
    # current_user?
    listing = Listing.find(params['id'])
    # .select { |event| event.id === params[:id].to_i}
    if listing
      listing.destroy
      render json: { message: 'Listing Successfully Deleted' }
    else
      render json: { error: 'Delete Unsuccessful' }
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:url, :score, :suggestion, :playlist_id, :position, :name)
  end
end
