class Notification
  include Mongoid::Document  
  include Mongoid::Timestamps
  field :message, type: String
  field :to, type: String
  belongs_to :user
end
