class MenuItem
  include Mongoid::Document
  field :Item_name, type: String
  field :Prize, type: String
  field :Description, type: String
  field :quantity, type: String
  field :menu_id, type: String

  validates :menu_id, :Item_name, :Prize,  :presence => true
  belongs_to :menu  
  
  validates :Item_name, uniqueness: true
end
