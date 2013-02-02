class NcommentsController < ApplicationController
  def new
  	@ncomment = Ncomment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ncomment }
    end
  end

  def show
    @ncomment = Ncomment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ncomment }
    end
  end

  def create
    @ncomment = Ncomment.new(params[:ncomment])

    respond_to do |format|
      if @ncomment.save

        if is_follower_of(@ncomment.user, @ncomment.comment.post)
          Follower.create(:post_id => @ncomment.comment.post.id, :user_id => @ncomment.user.id)
        end

        @ncomment.comment.post.followers.each do |follower|
          if follower.user != @ncomment.comment.user && follower.user != @ncomment.comment.post.user
            Notification.create(:content => "<a href='/users/#{@ncomment.user.id}'>#{@ncomment.user.name}</a> commented on <a href='/users/#{@ncomment.comment.user.id}'>#{@ncomment.comment.user.name}</a>'s comment on '<a href='/posts/#{@ncomment.comment.post.id}##{@ncomment.comment.id}'>#{@ncomment.comment.post.title}</a>'", :user_id => follower.user.id)
          end
        end

        format.js
      end
    end
  end

  def destroy
    @ncomment = Ncomment.find(params[:id])
    @ncomment.destroy

    respond_to do |format|
      format.js
    end
  end
end