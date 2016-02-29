class Rating
  include Mongoid::Document
  field :rating_no, type: Integer
  field :comment, type: String
  belongs_to :user
  belongs_to :hotel
end
