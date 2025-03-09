class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find_by(unique_code: params[:chatroom_id])
    stream_from "chatroom_#{chatroom.id}" if chatroom
  end

  def receive(data)
    chatroom = Chatroom.find_by(unique_code: data["chatroom_id"])
    return unless chatroom

    message = chatroom.messages.create(content: data["content"], sender: data["sender"])
    ActionCable.server.broadcast "chatroom_#{chatroom.id}", message
  end
end
