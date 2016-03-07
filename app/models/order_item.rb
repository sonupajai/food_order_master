class OrderItem
  include Mongoid::Document
  field :menu_item_id, type: String
  field :quantity, type: Integer, default: 1
  belongs_to :order
  belongs_to :menu_item

  delegate :price, to: :menu_item, prefix: true
end
