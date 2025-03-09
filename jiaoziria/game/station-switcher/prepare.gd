extends Button

# go to the 1-order scene
func _on_Button_pressed():
    get_tree().change_scene_to("res://2-prep.tscn")
    # get_tree().change_scene("res://scenes/1-order.tscn")
    # get_tree().reload_current_scene()
