class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @forums = Forum.all
    if params[:forum] != nil && params[:forum] != ""
      @posts = Post.find(:all, :conditions => "forum_id = #{params[:forum]}")
    end
    if params[:search] != nil && params[:search] != ""
      @posts = Post.find(:all, :conditions => ['title LIKE ?', "%#{params[:search]}%"])
      if params[:forum] != nil && params[:forum] != ""
        @posts = Post.find(:all, :conditions => ["title LIKE ? and forum_id = ?", "#{params[:search]}", "#{params[:forum]}"])
      end
    end
    @posts = @posts.paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @ncomment = Ncomment.new
    @plusone = Plusone.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @forums = Forum.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @forums = Forum.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @forums = Forum.all
    respond_to do |format|
      if @post.save
        Follower.create(:post_id => @post.id, :user_id => @post.user.id)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        @post.update_attributes(:post_updated_at => Time.current, :post_updated_by => current_user.id)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
