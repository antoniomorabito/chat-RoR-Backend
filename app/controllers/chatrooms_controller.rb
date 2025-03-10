class ChatroomsController < ApplicationController
    before_action :set_chatroom, only: [:show]
  
    def create
      chatroom = Chatroom.new(chatroom_params)
  
      if chatroom.save
        render json: { chatroom: chatroom, join_url: chatroom.unique_code }, status: :created
      else
        render json: { error: chatroom.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: @chatroom
    end
  
    private
  
    def set_chatroom
        @chatroom = Chatroom.where(unique_code: params[:id]).first
        
        unless @chatroom
          render json: { error: "Chatroom not found" }, status: :not_found
          return  
        end
      end
      
      
  
    def chatroom_params
      params.require(:chatroom).permit(:name)
    end
  end
  