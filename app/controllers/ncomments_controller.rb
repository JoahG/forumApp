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
        format.html { redirect_to @ncomment.comment.post }
        format.json { render json: @ncomment, status: :created, location: @ncomment }
      else
        format.html { render action: "new" }
        format.json { render json: @ncomment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ncomment = Ncomment.find(params[:id])
    p = @ncomment.comment.post
    @ncomment.destroy

    respond_to do |format|
      format.html { redirect_to p }
      format.json { head :no_content }
    end
  end
end