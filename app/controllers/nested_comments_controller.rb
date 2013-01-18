class NestedCommentsController < ApplicationController
  def new
  	@nestedcomment = NestedComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nestedcomment }
    end
  end

  def show
    @nestedcomment = NestedComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nestedcomment }
    end
  end

  def create
    @nestedcomment = NestedComment.new(params[:nestedcomment])

    respond_to do |format|
      if @nestedcomment.save
        format.html { redirect_to @nestedcomment.post }
        format.json { render json: @nestedcomment, status: :created, location: @nestedcomment }
      else
        format.html { render action: "new" }
        format.json { render json: @nestedcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @nestedcomment = NestedComment.find(params[:id])
    p = @nestedcomment.comment.post
    @nestedcomment.destroy

    respond_to do |format|
      format.html { redirect_to p }
      format.json { head :no_content }
    end
  end
end
