class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.where(unique_code: params[:chatroom_id]).first

    if chatroom
      stream_from "chatroom_#{chatroom.id}"
    else
      reject_subscription
    end
  end
  
  def receive(data)
    chatroom = Chatroom.where(unique_code: data["chatroom_id"]).first
    return unless chatroom

    message = chatroom.messages.create(content: data["content"], sender: data["sender"])
    
    if message.persisted?
      ActionCable.server.broadcast("chatroom_#{chatroom.id}", message.as_json)
    end
  end
end
