class MessagesController < ApplicationController
    def create
      chatroom = Chatroom.find_by(unique_code: params[:chatroom_id])
      return render json: { error: "Chatroom not found" }, status: :not_found unless chatroom
  
      message = chatroom.messages.create(content: params[:content], sender: params[:sender])
      ActionCable.server.broadcast "chatroom_#{chatroom.id}", message
      render json: message, status: :created
    end
  
    def index
      chatroom = Chatroom.find_by(unique_code: params[:chatroom_id])
      return render json: { error: "Chatroom not found" }, status: :not_found unless chatroom
  
      render json: chatroom.messages.order(created_at: :asc)
    end
  end
  