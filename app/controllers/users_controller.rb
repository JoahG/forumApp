class UsersController < ApplicationController
  def rank
    @users = User.find(:all)
    @users.sort! { |a,b| collect_plus(a) <=> collect_plus(b)}
    @users = @users.reverse[0..9]

    @rusers = User.find(:all)
    @rusers.sort! { |a,b| a.plusones.length <=> b.plusones.length }
    @rusers = @rusers.reverse[0..9]

    @tcp = Post.find(:all)
    @tcp.sort! { |a,b| a.comments.length <=> b.comments.length}
    @tcp = @tcp.reverse[0]

    @tcc = Comment.find(:all)
    @tcc.sort! {|a,b| a.ncomments.length <=> b.ncomments.length}
    @tcc = @tcc.reverse[0]

    @mc = User.find(:all)
    @mc.sort! { |a,b| collect_comments(a) <=> collect_comments(b) }
    @mc = @mc.reverse[0..9]

    @mp = User.find(:all)
    @mp.sort! { |a,b| collect_posts(a) <=> collect_posts(b) }
    @mp = @mp.reverse[0..9]

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.posts.each do |post|
      post::destroy
    end
    @user.comments.each do |comment|
      comment::destroy
    end
    @user.ncomments.each do |ncomment|
      ncomment::destroy
    end
    t = false
    if current_user == @user
      t = true
    end
    @user.destroy
    if t
      session[:user_id] = nil
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_admin
    u = User.find(params[:id])
    u.update_attribute(:admin, true)

    respond_to do |format|
      format.html {redirect_to users_url}
    end
  end

  def make_not_admin
    u = User.find(params[:id])
    u.update_attribute(:admin, false)

    respond_to do |format|
      format.html {redirect_to users_url}
    end
  end

  def make_mod
    u = User.find(params[:id])
    u.update_attribute(:moderator, true)

    respond_to do |format|
      format.html {redirect_to users_url}
    end
  end

  def make_not_mod
    u = User.find(params[:id])
    u.update_attribute(:moderator, false)

    respond_to do |format|
      format.html {redirect_to users_url}
    end
  end
end
