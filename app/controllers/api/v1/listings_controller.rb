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
    #listing = current_flatmate.listings.select { |listing| listing.id === params[:id] }

    listing = Listing.find(params[:id])
    if listing
      listing.update(listing_params)
      render json: { listing: ListingSerializer.new(listing) }, status: :created
    else
      render json: { error: "Update Unsuccessful" }
    end
  end

  def update_position
    listing_id = params["listing"]["id"]
    current_position = params["listing"]["position"]

    playlist = Playlist.find(params["listing"]["playlist_id"])
    songs = playlist.listings
    sorted = songs.sort { |a,b| a.position <=> b.position}

    if params["id"] == "up" && sorted[current_position + 1]
      other_listing = sorted.filter{ |listing| listing.position == current_position + 1}.last
      
      Listing.update(other_listing.id, :position => current_position)
      Listing.update(listing_id, :position => current_position + 1)
      
      render json: { messsage: "Moved Up!"  }, status: :created
    #check for valid move (cannot go above the top, or below bottom)
    
  else
    render json: { error: "You can't move above the top!" }
    end
  end

  def destroy

    #current_user?
    listing = Listing.find(params["id"])
    #.select { |event| event.id === params[:id].to_i}
    if listing
      listing.destroy
      render json: { message: "Listing Successfully Deleted" }
    else
      render json: { error: "Delete Unsuccessful" }
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:url, :score, :suggestion, :playlist_id, :position, :name)
  end
end
