class Area
  include Mongoid::Document
  field :name, type: String
  field :pincode, type: Integer
  belongs_to :city
  has_and_belongs_to_many :hotels
  validates :city_id, presence: true
  validates :name, :pincode, presence: true, uniqueness: true
  validates :pincode, length: { is: 6 }
end
