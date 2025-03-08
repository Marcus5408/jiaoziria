extends Control

func _on_order_pressed():
    print("Order button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://1-order.tscn")


func _on_prepare_pressed() -> void:
    print("Prep button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://2-prep.tscn")


func _on_cook_pressed() -> void:
    print("Cook button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://3-cook.tscn")


func _on_sauce_pressed() -> void:
    print("Sauce button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://4-sauce.tscn")
