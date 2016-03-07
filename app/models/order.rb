class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :status, type: String, default: "new"
  belongs_to :user
  belongs_to :hotel
  has_many :order_items, dependent: :destroy
end
