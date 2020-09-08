class CommentsController < ApplicationController

    def new
        @comment = Comment.new
        flash[:post] = flash[:post]
    end

    def create
        @comment = Comment.create(comment_params(:content))
        if @comment.valid?
            @comment.update(user_id: @signed_in_user, post_id: flash[:post])
            redirect_to user_path(@signed_in_user)
        else
            flash[:errors] = @comment.errors.full_messages
            flash[:post] = flash[:post]
            redirect_to new_comment_path
        end
    end
end
