class NotificationsController < ApplicationController
  def new
  	@notification = Notification.new
  end

  def create
    User.all.each do |u|
      Notification.create(:content => "<span class='admin_alert'>"+params[:notification][:content]+"</span>", :user_id => u.id)
    end

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.js
    end
  end
end
