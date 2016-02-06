class Menu
  include Mongoid::Document
  field :Menu_name, type: String
  field :description, type: String
  has_many :menu_items
  validates :Menu_name, :presence => true, uniqueness: true
  
end
