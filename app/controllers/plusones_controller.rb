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
  			if @plusone.user != @plusone.comment.user
	          Notification.create(:content => "<a href='/users/#{@plusone.user.id}'>#{@plusone.user.name}</a> +1'd your comment on '<a href='/posts/#{@plusone.comment.post.id}'>#{@plusone.comment.post.title}</a>'", :user_id => @plusone.comment.user.id)
	        end
  			format.html {redirect_to @plusone.comment.post}
  		else
  			format.html {redirect_to @plusone.comment.post}
  		end
  	end
  end
end
