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
