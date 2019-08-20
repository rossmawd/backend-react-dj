class Api::V1::DislikesController < ApplicationController

  def index
    dislikes = Dislikes.all

    render json: dislikes
  end

  def create

    dislike = Dislike.create(dislike_params)
    
    user_id = params["dislike"]["user_id"]
    listing_id =  params["dislike"]["listing_id"]
    like = Like.find_by( user_id: user_id, listing_id: listing_id)

    if like
      like.destroy
    end
   
    if dislike.valid?
      user = User.find(like.user_id)
      email = user.email
      listing = Listing.find(like.listing_id)
      playlist = Playlist.find(listing.playlist_id)
      listing_name = listing.name
      message = email + " dislikes " + "'"+listing_name+"'"
      jeff = {"text" => message, "id" => 1, "listing_id" => listing.id, "playlist_id" => playlist.id}
      ActionCable.server.broadcast('notes', jeff )

      render json: dislike, status: :created
    else
      render json: { errors: dislike.errors.full_messages }, status: :not_accepted
    end
  end

  def destroy
   
    dislike = Dislike.find(params['id'])
  
    if dislike
      dislike.destroy
      render json: { message: 'dislike Successfully Deleted' }
    else
      render json: { error: 'Delete Unsuccessful' }
    end
  end

  private

  def dislike_params
    params.require(:dislike).permit(:listing_id, :user_id)
  end

end
