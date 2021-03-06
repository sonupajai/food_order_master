class Hotel
  include Mongoid::Document
  include Mongoid::Paperclip
  has_mongoid_attached_file :image
  field :name, type: String
  field :type, type: String
  field :city_id, type: String
  field :speciality, type: String
  field :address, type: String
  field :owner_id, type: String
  field :status, type: String, default: "Pending"
  has_many :delivery_areas
  has_many :menus
  has_many :orders
  has_many :ratings
  belongs_to :user
  belongs_to :city
  has_and_belongs_to_many :areas
  do_not_validate_attachment_file_type :image
  validates :name, :type, :city_id, :presence => true

  #validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  def get_delivery_area_for_hotel(area_id)
    DeliveryArea.where({ hotel_id: id, area_id: area_id }).try(:first)
  end
end


