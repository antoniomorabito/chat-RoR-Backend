class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document

  
  field :content, type: String
  field :sender, type: String

  
  belongs_to :chatroom, index: true

  
  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :sender, presence: true, length: { maximum: 100 }

  
  paginates_per 20
end
