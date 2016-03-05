class Notification
  include Mongoid::Document  
  include Mongoid::Timestamps
  field :message, type: String
  field :to, type: String
  field :status, type: String, default: "unread"
  belongs_to :user
end
