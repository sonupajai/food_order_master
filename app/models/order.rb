class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_id, type: String
  field :status, type: String, default: "new"
  belongs_to :user
  has_many :order_items
end
