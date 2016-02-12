module HotelsHelper
	def get_delivery_area_for_hotel(id,area_id)
    DeliveryArea.where({ hotel_id: id, area_id: area_id }).try(:first)
  end
end
