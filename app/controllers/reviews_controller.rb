class ReviewsController < ApplicationController
  before_action :require_user

  def create
    review = Review.new(review_params)
    review.product_id = params['product_id']
    review.user_id = cookies.encrypted[:user_session]

    if review.save
      redirect_to :back
    end
  end

  def review_params
    params.require(:review).permit(:rating, :description, :product_id, :user_id)
  end
end
