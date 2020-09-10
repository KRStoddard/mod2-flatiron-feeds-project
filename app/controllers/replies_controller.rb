class RepliesController < ApplicationController
    before_action :keep_comment, only: [:new]

    def new
        @reply = Reply.new
    end

    def create
        @reply = Reply.create(user_id: @signed_in_user.id, comment_id: flash[:comment], likes: 0)
        @reply.update(reply_params(:content))
        if @reply.valid?
            redirect_to comment_path(@reply.comment_id)
        else
            keep_comment
            flash[:errors] = @reply.errors.full_messages
            redirect_to new_reply_path
        end
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
