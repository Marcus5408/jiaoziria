extends Node2D

@export var customerNodeData: CustomerDetails

signal take_order_button_pressed(customerNodeData: Variant, customerName: String)

func _on_button_pressed() -> void:
	if !customerNodeData:
		printerr("Customer data is not set!")
		return
	emit_signal("take_order_button_pressed", customerNodeData, self.name)
	print("Get order button pressed: ", customerNodeData.characterResource.name)
