class Api::V1::LikesController < ApplicationController
  #  skip_before_action :authorize, only: [:create]
  def index
    likes = Likes.all

    render json: likes
  end

  def create
    like = Like.create(like_params)

    user_id = params["like"]["user_id"]
    listing_id =  params["like"]["listing_id"]
    dislike = Dislike.find_by( user_id: user_id, listing_id: listing_id)
  
    if dislike
      dislike.destroy
    end

    if like.valid?
      user = User.find(like.user_id)
      email = user.email
      listing = Listing.find(like.listing_id)
      listing_name = listing.name
      message = email + " likes " + listing_name
      jeff = {"text" => message, "id" => 1}
      ActionCable.server.broadcast('notes', jeff )
      render json: like, status: :created
    else
      render json: { errors: like.errors.full_messages }, status: :not_accepted
    end
  end

  def destroy
   
    like = Like.find(params['id'])
  
    if like
      like.destroy
      render json: { message: 'like Successfully Deleted' }
    else
      render json: { error: 'Delete Unsuccessful' }
    end
  end

  private

  def like_params
    params.require(:like).permit(:listing_id, :user_id)
  end

end
