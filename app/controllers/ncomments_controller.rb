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
        if @ncomment.user != @ncomment.comment.user
          Notification.create(:content => "<a href='/users/#{@ncomment.user.id}'>#{@ncomment.user.name}</a> commented on your comment on '<a href='/posts/#{@ncomment.comment.post.id}##{@ncomment.comment.id}'>#{@ncomment.comment.post.title}</a>'", :user_id => @ncomment.comment.user.id)
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