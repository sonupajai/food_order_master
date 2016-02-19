class DeliveryArea
  include Mongoid::Document
  field :area_id, type: BSON::ObjectId
  field :hotel_id, type: BSON::ObjectId
  field :delivery_time, type: String, default: "1hr"
  field :delivery_charges, type: String, default: "0"
  field :min_order_amount, type: String, default: "0"
  field :user_id, type: String
  validates_uniqueness_of :area_id, :scope => :hotel_id
  belongs_to :city
  belongs_to :hotel
  belongs_to :area
end
