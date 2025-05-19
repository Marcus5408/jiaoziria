extends Control

func _on_store_view_customer_take_order_button_pressed(customerNodeData:Variant, _customerName:String) -> void:
	# instantiate the customer's asset
	# and add it to the scene tree
	var asset = customerNodeData.characterResource.asset
	var customer_instance = asset.instantiate()
	add_child(customer_instance)

	# place the customer in the center of the screen
	customer_instance.position = Vector2(960, 960)
	var customerAssetNode = get_node("CustomerNode")
	customerAssetNode.get_node("Button").hide()

	# start a timer
	var timer = Timer.new()
	timer.wait_time = 5.0
