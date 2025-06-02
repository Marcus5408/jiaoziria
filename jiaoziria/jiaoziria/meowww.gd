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
var sauceIn
var group
func _ready():
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
	if(inArea and Global.full == false):
		global_position = areas
		Global.full = true
	else:
		position = original_position

func _on_area_2d_area_entered(monkey: Area2D) -> void:
	sauceIn = str(get_groups())
	sauceIn = sauceIn.substr(3, sauceIn.length() - 5)
	if(monkey.get_node("snappointe") != null):
		inArea = true
		areas = monkey.get_node("snappointe").global_position

func _on_area_2d_area_exited(area: Area2D) -> void:
	inArea = false
	if(Global.full == true):
		Global.full = false
	print("potttt")


func _on_finish_dumpling_pressed() -> void:
	if(Global.ingred["s"] == 5 and sauceIn == "none"):
			Global.score += 1
	if(Global.ingred["s"] == 0 and sauceIn == "1"):
			Global.score += 1
	if(Global.ingred["s"] == 1 and sauceIn == "2"):
			Global.score += 1
	if(Global.ingred["s"] == 2 and sauceIn == "3"):
			Global.score += 1
	if(Global.ingred["s"] == 3 and sauceIn == "4"):
			Global.score += 1
	if(Global.ingred["s"] == 4 and sauceIn == "5"):
			Global.score += 1
	Global.three = true
	parent.visible = false

func _on_area_2d_area_enteredMeow(area: Area2D) -> void:
	print("meow")
func _on_area_2d_area_exitedMeow(area: Area2D) -> void:
	print("rawr")
