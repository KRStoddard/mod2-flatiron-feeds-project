class ChatmembersController < ApplicationController
    before_action :keep_chat, only: [:new, :destroy]

    def new
        @chatmember = Chatmember.new 
        @users = User.all.select{|user| user.username != "deleted_user"}
        @chats = @signed_in_user.chats.all 
    end

    def create
        @chatmember = Chatmember.create(chatmember_params(:user_id, :chat_id))
        if @chatmember.valid?
            redirect_to chat_path(@chatmember.chat_id)
        else
            keep_chat
            flash[:errors] = @chatmember.errors.full_messages
            redirect_to new_chatmember_path
        end
    end

    def destroy
        @chatmember = Chatmember.find(params[:id])
        @chatmember.destroy
    end

    private

    def chatmember_params(*args)
        params.require(:chatmember).permit(*args)
    end

end
