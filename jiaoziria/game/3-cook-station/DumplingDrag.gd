extends Node2D

# follow mouse when dragging
var dragging = false
var drag_offset = Vector2()
var dumpling_skin_active = false
var original_position = global_position
var inArea = false
var areas
var timed = false;
var	preTime
var postTime 
var secTime
var aree
var safeZone = false
var parent
var ticket
func _ready():
	ticket = $"res://assets/ticket/ticket.gd"
	parent = get_parent()
	original_position = global_position
	inArea = false
	preTime = parent.get_node("SubTimer")
	postTime = parent.get_node("PostTimer")
	secTime = parent.get_node("SecTimer")
# when mouse held down on the dumpling skin
func _on_texture_button_button_down():
	dragging = true
	drag_offset = get_global_mouse_position() - position
	if(timed):
		secTime.stop()
		if(safeZone):
			print("add point");
	print("Dumpling skin pressed, dragging started")

func _process(_delta):
	if dragging:
		position = get_global_mouse_position() - drag_offset
# when mouse released
func _on_texture_button_button_up():
	dragging = false
	if(inArea):
		if(!timed):
			startingClock()
		global_position = areas
	else:
		position = original_position

func _on_area_2d_area_entered(monkey: Area2D) -> void:
	inArea = true
	areas = monkey.get_node("SnapPoint").global_position
	print(monkey.to_string());
	if(monkey.name == "AreaT1"):
		aree = parent.get_node("Tbar1")
	elif(monkey.name == "AreaT2"):
		aree = parent.get_node("Tbar2")
	elif(monkey.name == "AreaT3"):
		aree = parent.get_node("Tbar3")
	elif(monkey.name == "AreaT4"):
		aree = parent.get_node("Tbar4")
	elif(monkey.name == "AreaB1"):
		aree = parent.get_node("Bbar1")
	elif(monkey.name == "AreaB2"):
		aree = parent.get_node("Bbar2")
	elif(monkey.name == "AreaB3"):
		aree = parent.get_node("Bbar3")
	elif(monkey.name == "AreaB4"):
		aree = parent.get_node("Bbar4")
	print(aree)
	print(areas)
	print(inArea)
	print(original_position)

func startingClock():
	print(ticket.cookingMethod)
	if((aree == parent.get_node("Tbar1")) or (aree == parent.get_node("Tbar2")) or (aree == parent.get_node("Bbar1")) or (aree == parent.get_node("Bbar2"))):
		if(Global.ingred["cm"] == 0):
			#points up
			var red = 1
		else:
			#points down
			var blue = 3
	else:
		if(Global.ingred["cm"] == 1):
			#points up
			var green = 3
		else:
			#points down
			var burr = 3
	timed = true
	aree.get_node("Sprite2D2").visible = true
	aree.get_node("Sprite2D2").scale = Vector2(0, 1)
	secTime.start(1)
	preTime.start(9.5)
	postTime.start(10.5)
func _on_area_2d_area_exited(area: Area2D) -> void:
	inArea = false
	print("potttt")

func sOut() -> void:
	safeZone = true
func pOut() -> void:
	safeZone = false;
func seOut() -> void:
	aree.get_node("Sprite2D2").scale = Vector2(aree.get_node("Sprite2D2").scale.x + 0.1, 1)
