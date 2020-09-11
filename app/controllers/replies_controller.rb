class RepliesController < ApplicationController
    before_action :keep_comment, only: [:new]

    def new
        @reply = Reply.new
    end

    def create
        @reply = Reply.create(user_id: @signed_in_user.id, comment_id: flash[:comment], likes: 0)
        @reply.update(reply_params(:content))
        if @reply.valid?
            (Comment.find(@reply.comment_id).users.uniq - [@signed_in_user]).each do |user|
                Notification.create(recipient: user, actor: @signed_in_user, action: "posted", notifiable: @reply)
            end
            redirect_to comment_path(@reply.comment_id)
        else
            keep_comment
            flash[:errors] = @reply.errors.full_messages
            redirect_to new_reply_path
        end
    end

    def like
        @reply = Reply.find(params[:id])
        @reply.likes += 1
        @reply.save

        redirect_to comment_path(@reply.comment_id)
    end

    def destroy
        @reply = Reply.find(params[:id])
        @reply.destroy 
        redirect_to comment_path(flash[:comment])
    end

    private

    def reply_params(*args)
        params.require(:reply).permit(*args)
    end
end
