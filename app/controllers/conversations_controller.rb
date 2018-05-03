class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :who_is_it, only: [:index, :create]

    def index
      @users = User.all

      # get all conversations involving current_user
      @conversations = Conversation.involving(current_user)
    end

    def create
      if Conversation.between(params[:sender_id],params[:recipient_id]).present?
        # Conversationテーブルの先頭のレコードを取得する
        @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
      else
        @conversation = Conversation.create(conversation_params)
      end

      redirect_to conversation_messages_path(@conversation)
    end

    private
    def conversation_params
        params.permit(:sender_id, :recipient_id)
    end
    def who_is_it
      if user_signed_in?
        @admin_user = true if Member.where("user_id = ? and admin = ?",current_user.id, true).present?
      end
    end
end




