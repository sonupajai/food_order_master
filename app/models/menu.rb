class Menu
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :hotel_id, type: Integer
  
  belongs_to :hotel
  has_many :menu_items
  validates :name, presence: true, uniqueness: true	
end
