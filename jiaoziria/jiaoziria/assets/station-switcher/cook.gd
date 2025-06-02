extends Button

func _ready():
    connect("pressed", Callable(self, "_on_cook_Button_pressed"))

# go to the 1-order scene
func _on_cook_Button_pressed():
    print("Button pressed, attempting to change scene")
    get_tree().change_scene("res://3-cook.tscn")