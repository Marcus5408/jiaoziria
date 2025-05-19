extends Node2D

# follow mouse when dragging
var dragging = false
var drag_offset = Vector2()
var dumpling_skin_active = false
var original_position = global_position
var inArea = false
var areas
var aree
var parent
var ticket
func _ready():
	ticket = $"res://assets/ticket/ticket.gd"
	parent = get_parent()
	original_position = global_position
	inArea = false
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
	if(inArea):
		global_position = areas
	else:
		position = original_position

func _on_area_2d_area_entered(monkey: Area2D) -> void:
	inArea = true
	areas = monkey.get_node("SnapPoint").global_position
	print(monkey.to_string());
	if(monkey.name == "AreaT1"):
		aree = parent.get_node("Tbar1")
	print(aree)
	print(areas)
	print(inArea)
	print(original_position)

func _on_area_2d_area_exited(area: Area2D) -> void:
	inArea = false
	print("potttt")
