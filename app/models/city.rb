class City
  include Mongoid::Document
  field :name, type: String, default: ""
  has_many :areas
  has_many :hotels
  validates :name, presence: true, uniqueness: true
end
