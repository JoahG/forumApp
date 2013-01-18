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