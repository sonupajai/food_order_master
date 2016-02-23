class City
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String, default: ""
  field :user_id, type: String
  has_many :areas
  has_many :hotels
  validates :name, presence: true, uniqueness: true
end
