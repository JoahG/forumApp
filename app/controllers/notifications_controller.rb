class NotificationsController < ApplicationController
  def new
  	@notification = Notification.new
  end

  def create
  	@notification = Notification.new(params[:comment])
  end

  def destroy
    @notification = Notification.find(params[:id])
    p = @notification.user
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to p }
      format.json { head :no_content }
    end
  end
end
