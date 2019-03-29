class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :welcome]
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:destroy, :edit, :update]

  def create
    @idea = Idea.find params[:idea_id]
    @review = Review.new review_params
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      redirect_to idea_url(@idea.id)
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render "ideas/show"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to idea_url(@review.idea)
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end

  def authorize_user!
    redirect_to root_path, alert: "access denied" unless can? :crud, @review
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
