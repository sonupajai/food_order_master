class MenuItem
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
  field :quantity, type: Integer
  field :description, type: String

  belongs_to :menu
end
