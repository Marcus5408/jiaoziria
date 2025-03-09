extends Control

func _on_order_pressed():
    print("Order button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/1-order.tscn")
    Main.current_scene = "order"


func _on_prepare_pressed() -> void:
    print("Prep button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/2-prep.tscn")
    Main.current_scene = "prep"


func _on_cook_pressed() -> void:
    print("Cook button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/3-cook.tscn")
    Main.current_scene = "cook"


func _on_sauce_pressed() -> void:
    print("Sauce button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/4-sauce.tscn")
    Main.current_scene = "sauce"
