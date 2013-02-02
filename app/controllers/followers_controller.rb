class FollowersController < ApplicationController
  def new
  	@follower = Follower.new
  end

  def create
  	@follower = Follower.new(params[:follower])

  	respond_to do |format|
  		if @follower.save
  			format.html {redirect_to @follower.post}
  		end
  	end
  end

  def destroy
  end
end
