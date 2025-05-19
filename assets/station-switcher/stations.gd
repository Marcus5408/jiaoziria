extends Control

signal station_changed_to_order
signal station_changed_to_prep
signal station_changed_to_cook
signal station_changed_to_sauce

func _on_order_pressed() -> void:
	emit_signal("station_changed_to_order")

func _on_prepare_pressed() -> void:
	emit_signal("station_changed_to_prep")

func _on_cook_pressed() -> void:
	emit_signal("station_changed_to_cook")

func _on_sauce_pressed() -> void:
	emit_signal("station_changed_to_sauce")


func _on_store_view_customer_take_order_button_pressed(_customerNodeData:Variant, _customerName:String) -> void:
	self.hide()

func _on_ticket_layer_order_taken(_customerName:String) -> void:
	self.show()
