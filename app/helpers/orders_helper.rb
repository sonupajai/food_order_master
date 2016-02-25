module OrdersHelper
	def order_amount(od)
		sum=0
		 @orderitems= od.order_items.all
		 @orderitems.each do |oi|
		 	sum+=oi.menu_item.price
		 end
		 sum
	end
end
