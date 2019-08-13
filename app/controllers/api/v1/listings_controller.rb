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



  def destroy
    
    #current_user?
    listing = Listing.find(params["id"])
    #.select { |event| event.id === params[:id].to_i}
    if listing
      listing.destroy
      render json: {message: "Listing Successfully Deleted"}
    else
      render json: {error: "Delete Unsuccessful"}
    end
  end


  private 

  def listing_params
    params.require(:listing).permit(:url, :score, :suggestion, :playlist_id, :position, :name)
  end

end
