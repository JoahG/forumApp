class NestedComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  attr_accessible :comment_id, :content, :user_id
  before_save :render_body

  private
  def render_body
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.content = redcarpet.render self.content
  end
end
