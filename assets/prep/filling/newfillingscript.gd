extends Node2D

# follow mouse when dragging
var dragging = false
var drag_offset = Vector2()
var filling_skin_active = false
@onready var prepstation = get_parent().get_parent()

var original_position = Vector2()
@onready var filling_skin = get_parent()

# when mouse held down on the dumpling skin
func _on_texture_button_button_down():
	dragging = true
	drag_offset = get_global_mouse_position() - position
	print("Filling skin pressed, dragging started")

func _process(_delta):
	if dragging:
		self.position = get_global_mouse_position() - drag_offset

# when mouse released
func _on_texture_button_button_up():
	dragging = false
	print("Fillng skin released, dragging stopped")
