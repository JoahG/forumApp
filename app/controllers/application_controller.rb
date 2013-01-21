class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :redirect_to_home
  helper_method :render_body
  helper_method :render_aboutme
  
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
end
