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
<<<<<<< HEAD
  #----------------Associations-----------------#
  has_many :delivery_areas
  has_many :menus

  belongs_to :user 
=======
  belongs_to :user
>>>>>>> eea04fa0c6b8a01a45b43fee179780e63e7ec0ea
  belongs_to :city

  has_and_belongs_to_many :areas
#-------------------END-------------------------#
  do_not_validate_attachment_file_type :image
  validates :name, :type, :city_id, :presence => true
<<<<<<< HEAD
 #validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
=======
  has_and_belongs_to_many :menus

  #validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
>>>>>>> eea04fa0c6b8a01a45b43fee179780e63e7ec0ea

  def get_delivery_area_for_hotel(area_id)
    DeliveryArea.where({ hotel_id: id, area_id: area_id }).try(:first)
  end
end
















