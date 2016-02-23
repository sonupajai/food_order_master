class Menu
  include Mongoid::Document
  include Mongoid::Paperclip
  has_mongoid_attached_file :image
  field :name, type: String
  field :user_id, type: String

  belongs_to :hotel
  has_many :menu_items
  validates :name, presence: true, uniqueness: true
  do_not_validate_attachment_file_type :image
end
