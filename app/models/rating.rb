class Rating
  include Mongoid::Document
  field :user_id, type: String
  field :hotel_id, type: String
  field :rating_no, type: Integer
  field :comment, type: String
  belongs_to :user
  belongs_to :hotel
end
