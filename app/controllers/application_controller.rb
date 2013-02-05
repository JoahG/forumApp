class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :redirect_to_home
  helper_method :render_body
  helper_method :render_aboutme
  helper_method :collect_plus
  helper_method :collect_comments
  helper_method :collect_posts
  helper_method :is_follower_of
  helper_method :find_follower
  helper_method :rescue_action_in_public

  private

  def redirect_to_home(msg)
  	redirect_to root_url, :notice => msg
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def render_body(p)
    require 'redcarpet'
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, {fenced_code_blocks: true})
    return redcarpet.render p.content
  end

  def render_aboutme(p)
    require 'redcarpet'
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, {fenced_code_blocks: true})
    return redcarpet.render p
  end

  def collect_plus(u)
    p = 0
    u.comments.each do |c|
      if c.post
        p += c.plusones.length
      end
    end
    return p
  end

  def collect_comments(u)
    p = 0
    u.comments.each do |c|
      if c.post
        p += 1
      end
    end
    return p
  end

  def collect_posts(u)
    c = 0
    u.posts.each do |p|
      if p
        c += 1
      end
    end
    return c
  end

  def is_follower_of(u,p)
    t = true
    p.followers.each do |f|
      if f.user == u
        t = false
      end
    end
    return t
  end

  def find_follower(u,p)
    p.followers.each do |f|
      if f.user == u
        return f
      end
    end
  end

  def rescue_action_in_public(exception)
    Error.create :exception_name => exception.exception.to_s, :backtrace_info => exception.backtrace.to_s
    super
    redirect_to root_url
  end
end
