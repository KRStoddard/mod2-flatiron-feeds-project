class ChatsController < ApplicationController
    before_action :find_chat, only: [:show, :destroy, :edit, :update]

    def show
    end

    def new
        @chat = Chat.new
    end

    def create
        @chat = Chat.create(chat_params(:name))



    private

    def find_chat
        @chat = Chat.find(params[:id])
    end
end
