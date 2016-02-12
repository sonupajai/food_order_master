class MenuCategory
  include Mongoid::Document
  include Mongoid::Paperclip
  has_mongoid_attached_file :image
  field :name, type: String
  field :menu_category_id, type: Integer

  has_and_belongs_to_many :hotels
  has_many :menu_items
  validates :name, presence: true, uniqueness: true
  do_not_validate_attachment_file_type :image
end
