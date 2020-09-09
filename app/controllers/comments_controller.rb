class CommentsController < ApplicationController

    def new
        @comment = Comment.new
        flash[:post] = flash[:post]
        if flash[:group]
            flash[:group] = flash[:group]
        end
    end

    def create
        @comment = Comment.create(comment_params(:content))
        if @comment.valid?
            @comment.update(user_id: @signed_in_user.id, post_id: flash[:post], likes: 0)
            if flash[:group]
                redirect_to group_path(flash[:group])
            else
            redirect_to user_path(@signed_in_user)
            end
        else
            if flash[:group]
                flash[:group] = flash[:group]
            end
            flash[:errors] = @comment.errors.full_messages
            flash[:post] = flash[:post]
            redirect_to new_comment_path
        end
    end

    def like
        @comment = Comment.find(params[:id])
        @comment.likes += 1
        @comment.save

        redirect_to post_path(@comment.post_id)
    end

    private

    def comment_params(*args)
        params.require(:comment).permit(*args)
    end
end
