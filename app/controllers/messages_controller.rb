class MessagesController < ApplicationController

   
    def index
      chatroom = Chatroom.where(unique_code: params[:chatroom_id]).first
    
      unless chatroom
        return render json: { error: "Chatroom not found" }, status: :not_found
      end
    
      messages = chatroom.messages.order(created_at: :asc).page(params[:page]).per(params[:per_page] || 20)
    
      render json: {
        messages: messages,
        pagination: {
          current_page: messages.current_page,
          total_pages: messages.total_pages,
          total_count: messages.total_count
        }
      }
    end
  
  
  

  
    def create
      chatroom = Chatroom.find_by(unique_code: params[:chatroom_id])
      return render json: { error: "Chatroom not found" }, status: :not_found unless chatroom
  
      message = chatroom.messages.create(content: params[:content], sender: params[:sender])
      ActionCable.server.broadcast "chatroom_#{chatroom.id}", message
      render json: message, status: :created
    end
  
  end
  