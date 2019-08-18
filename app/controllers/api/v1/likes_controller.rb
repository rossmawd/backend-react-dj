class Api::V1::LikesController < ApplicationController
  #  skip_before_action :authorize, only: [:create]
  def index
    likes = Likes.all

    render json: likes
  end

  def create
    
    like = Like.create(like_params)

    if like.valid?
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
