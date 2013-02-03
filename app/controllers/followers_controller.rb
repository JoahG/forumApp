class FollowersController < ApplicationController
  def new
  	@follower = Follower.new
  end

  def create
  	@follower = Follower.new(params[:follower])

  	respond_to do |format|
  		if @follower.save
  			format.js
  		end
  	end
  end

  def destroy
    @follower = Follower.find(params[:id])

    respond_to do |format|
      if @follower.destroy
        format.js
      end
    end
  end
end
