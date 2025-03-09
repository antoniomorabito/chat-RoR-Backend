class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :sender, type: String  

  belongs_to :chatroom
end
