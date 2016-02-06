json.array!(@areas) do |area|
  json.extract! area, :id, :name, :pincode, :city_id
  json.url area_url(area, format: :json)
end
