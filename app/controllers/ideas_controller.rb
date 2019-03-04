class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :welcome]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:destroy, :edit, :update]

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new params.require(:idea).permit(:title, :body)
    @idea.user = current_user
    if @idea.save
      flash[:success] = "idea created successfully"
      redirect_to idea_path(@idea.id)
    else
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
    @review = Review.new
    @reviews = @idea.reviews.order(created_at: :desc)
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    flash[:success] = "Idea deleted successfully"
    redirect_to ideas_path
  end

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update params.require(:idea).permit(:title, :body)
      flash[:success] = "idea updated successfully"
      redirect_to idea_path(@idea.id)
    else
      flash[:danger] = "idea not updated"
      render :edit
    end
  end

  private

  def authorize_user!
    redirect_to root_path, alert: "access denied" unless can? :crud, @idea
  end

  def find_idea
    @idea = Idea.find(params[:id])
  end
end
