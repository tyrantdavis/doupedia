class WikisController < ApplicationController

  skip_before_filter :authenticate_user!

  def new
    @wiki = Wiki.new
  end

  def create
# #9
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

# #10
    if @wiki.save
# #11
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
# #12
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
      end
    end

    def index
      @wikis = Wiki.all
    end

    def show
      # @wiki = wiki.find(params[:id])

    end

  def edit
    @wiki = Wiki.find(params[:id])

  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

# #8
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
end
