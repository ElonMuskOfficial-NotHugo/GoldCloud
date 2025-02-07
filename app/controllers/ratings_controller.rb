class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rating, only: [:update, :destroy]
  before_action :authorize_admin, only: [:destroy]

  def create
    @rating = current_user.ratings.build(rating_params)
    if @rating.save
      redirect_to item_path(@rating.item), notice: 'Rating added!'
    else
      redirect_to item_path(@rating.item), alert: @rating.errors.full_messages.join(', ')
    end
  end

  def update
    if @rating.update(rating_params)
      redirect_to item_path(@rating.item), notice: 'Rating updated!'
    else
      redirect_to item_path(@rating.item), alert: @rating.errors.full_messages.join(', ')
    end
  end

  def destroy
    @rating.update(hidden: true)
    redirect_to item_path(@rating.item), notice: 'Rating hidden'
  end

  private

  def rating_params
    params.require(:rating).permit(:score, :comment, :item_id)
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'Not authorized'
    end
  end
end