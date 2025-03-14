class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show]

  def index
    chatrooms = Chatroom.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 10)
    render json: {
      chatrooms: chatrooms,
      pagination: {
        total_pages: chatrooms.total_pages,
        total_count: chatrooms.total_count,
        current_page: chatrooms.current_page
      }
    }
  end

  def create
    # Ensure the request is JSON
    unless request.format.json?
      render json: { error: "Not Acceptable – Request must be JSON" }, status: :not_acceptable
      return
    end

    chatroom = Chatroom.new(chatroom_params)
    if chatroom.save
      render json: { chatroom: chatroom.as_json(only: [:id, :name, :unique_code]), join_url: chatroom.unique_code }, status: :created
    else
      render json: { error: chatroom.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @chatroom
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find_by(unique_code: params[:id])
    unless @chatroom
      render json: { error: "Chatroom not found" }, status: :not_found
    end
  end

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
