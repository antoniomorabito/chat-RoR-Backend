class ChatroomsController < ApplicationController
    def create
      chatroom = Chatroom.create(name: params[:name])
      render json: { chatroom: chatroom, join_url: chatroom.unique_code }, status: :created
    end
  
    def show
      chatroom = Chatroom.find_by(unique_code: params[:id])
      if chatroom
        render json: chatroom
      else
        render json: { error: "Chatroom not found" }, status: :not_found
      end
    end
  end
  