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

    if !@ncomment.comment.post.locked?
      respond_to do |format|
        if @ncomment.save

          if is_follower_of(@ncomment.user, @ncomment.comment.post)
            @follower = Follower.new(:post_id => @ncomment.comment.post.id, :user_id => @ncomment.user.id)
            if @follower.save
              format.js { render 'follower.js.erb' }
            end
          end

          @ncomment.comment.post.followers.each do |follower|
            if follower.user != @ncomment.user
              Notification.create(:content => "<a href='/users/#{@ncomment.user.id}'>#{@ncomment.user.name}</a> commented on <a href='/users/#{@ncomment.comment.user.id}'>#{@ncomment.comment.user.name}</a>'s <a href='/posts/#{@ncomment.comment.post.id}##{@ncomment.comment.id}'>comment on '#{@ncomment.comment.post.title}'</a>", :user_id => follower.user.id)
            end
          end

          format.js
        end
      end
    else
      redirect_to @ncomment.comment.post
    end
  end

  def destroy
    @ncomment = Ncomment.find(params[:id])
    if !@ncomment.comment.post.locked?
      @ncomment.destroy
      respond_to do |format|
        format.js
      end
    end
  end
end