class NotificationsController < ApplicationController
    def index
        @notifications = Notification.where(recipient: @signed_in_user).unread
    end

    def update
        @notification = Notification.find(params[:id])
        @notification.update(read_at: Time.now)
        redirect_to notifications_path
    end
end

