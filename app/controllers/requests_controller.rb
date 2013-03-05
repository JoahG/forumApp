class RequestsController < ApplicationController
  def index
  	@requests = Request.all.reverse
  end
end
