class IdeasController < ApplicationController
  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new params.require(:idea).permit(:title, :body)
    # @idea.user = current_user
    if @idea.save
      flash[:success] = "idea created successfully"
      redirect_to idea_path(@idea.id)
    else
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
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
end
