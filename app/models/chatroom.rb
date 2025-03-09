class Chatroom
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :unique_code, type: String 

  has_many :messages, dependent: :destroy

  before_create :generate_unique_code

  private

  def generate_unique_code
    self.unique_code = SecureRandom.hex(5)  
  end
end
