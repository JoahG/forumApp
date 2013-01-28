class ForumsController < ApplicationController
  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    respond_to do |format|
      if @forum.save
        format.html {redirect_to root_url}
      end
    end
  end

  def edit
  end

  def destroy
    @forum = Forum.find(params[:id])
    @forum.posts.each do |p|
      p.destroy
    end
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def show
  end
end
