class MenuItem
  include Mongoid::Document
  field :name, type: String
  field :price, type: Integer
  field :quantity, type: String
  field :description, type: String
  field :discount, type: Integer
  field :user_id, type: String

  belongs_to :menu
  has_many :order_items
end
