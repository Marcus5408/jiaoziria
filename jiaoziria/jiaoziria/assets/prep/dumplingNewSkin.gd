extends Node2D

# follow mouse when dragging
var dragging = false
var drag_offset = Vector2()
var dumpling_skin_active = false
@onready var prepstation = get_parent().get_parent()

var original_position = Vector2()
@onready var dumpling_skin = $DumplingSkin

# when mouse held down on the dumpling skin
func _on_texture_button_button_down():
	dragging = true
	drag_offset = get_global_mouse_position() - position
	print("Dumpling skin pressed, dragging started")

func _process(_delta):
	if dragging:
		position = get_global_mouse_position() - drag_offset

# when mouse released
func _on_texture_button_button_up():
	dragging = false
	print("Dumpling skin released, dragging stopped")
	prepstation.dumpling_activate.call()
