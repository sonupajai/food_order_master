class DeliveryArea
  include Mongoid::Document
  include Mongoid::Timestamps
  field :area_id, type: BSON::ObjectId
  field :hotel_id, type: BSON::ObjectId  
  field :delivery_time, type: String
  field :delivery_charges, type: String
  field :min_order_amount, type: String
  validates_uniqueness_of :area_id, :scope => :hotel_id
  belongs_to :city
  belongs_to :hotel
  belongs_to :area
end
