class Api::V1::DislikesController < ApplicationController

  def index
    dislikes = Dislikes.all

    render json: dislikes
  end

  def create
    byebug
    dislike = Dislike.create(dislike_params)

    if dislike.valid?
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
