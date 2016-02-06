json.array!(@delivery_areas) do |delivery_area|
  json.extract! delivery_area, :id, :area_id, :hotel_id, :delivery_time, :delivery_charges, :min_order_amount
  json.url delivery_area_url(delivery_area, format: :json)
end
