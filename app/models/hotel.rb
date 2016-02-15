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
  #----------------Associations-----------------#
  has_many :delivery_areas
  belongs_to :city
  belongs_to :user 
  has_and_belongs_to_many :menus
  has_and_belongs_to_many :areas
#-------------------END-------------------------#
  do_not_validate_attachment_file_type :image
  validates :name, :type, :city_id, :presence => true
 #validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  def get_delivery_area_for_hotel(area_id)
    DeliveryArea.where({ hotel_id: id, area_id: area_id }).try(:first)
  end
end
















