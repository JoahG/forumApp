class PlusonesController < ApplicationController
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def create
  	@plusone = Plusone.new(params[:plusone])

  	respond_to do |format|
  		if @plusone.save
  			format.html {redirect_to @plusone.comment.post}
  		else
  			format.html {redirect_to @plusone.comment.post}
  		end
  	end
  end
end
