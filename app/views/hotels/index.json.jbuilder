json.array!(@hotels) do |hotel|
  json.extract! hotel, :id, :name, :type, :city, :speciality, :address, :owner_id
  json.url hotel_url(hotel, format: :json)
end
