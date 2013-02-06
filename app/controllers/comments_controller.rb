class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:update]
  def new
  	@comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  def edit 
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if current_user
      if current_user.admin? || current_user.moderator? || current_user == @comment.user
        respond_to do |format|
          if @comment.update_attributes(params[:comment])
            @comment.update_attributes(:comment_updated_at => Time.current, :comment_updated_by => current_user.id)
            @comment.save
            format.js
          end
        end
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html {redirect_to @comment.post}
      format.json { render json: @comment }
    end
  end

  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save

        if is_follower_of(@comment.user, @comment.post)
          @follower = Follower.new(:post_id => @comment.post.id, :user_id => @comment.user.id)
          if @follower.save
            format.js { render 'follower.js.erb' }
          end
        end

        @comment.post.followers.each do |follower|
          if follower.user != @comment.user
            Notification.create(:content => "<a href='/users/#{@comment.user.id}'>#{@comment.user.name}</a> commented on the post '<a href='/posts/#{@comment.post.id}##{@comment.id}'>#{@comment.post.title}</a>'", :user_id => follower.user.id)
          end
        end
        
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end
end
