class Api::V1::ListingsController < ApplicationController

  def index
    listings = Listing.all
    render json: listings
  end

  def create
    playlist = Playlist.find( params["listing"]["playlist_id"])
    playlist_length = playlist.listings.length
    new_listing_position =  playlist_length
    params["listing"]["position"] = new_listing_position

    listing = Listing.create(listing_params)

    if listing.valid?
      render json: { listing: ListingSerializer.new(listing) }, status: :created
    else
      render json: { errors: listing.errors.full_messages }, status: :not_accepted
    end
  end

  def update
    listing = Listing.find(params[:id])
    if listing
      listing.update(listing_params)
      render json: { listing: ListingSerializer.new(listing) }, status: :created
    else
      render json: { error: 'Update Unsuccessful' }
    end
  end

  def update_position
    playlist = Playlist.find(params['listing']['playlist_id'])
    updated_playlist = playlist.update_positions(params)  
    render json: updated_playlist
  end

  def destroy
    # current_user?
    listing = Listing.find(params['id'])
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
