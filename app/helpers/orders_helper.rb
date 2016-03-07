module OrdersHelper
	def order_amount(od)
		MenuItem.in(order_item_id: od.order_item_ids).sum(:price)
	end
end
