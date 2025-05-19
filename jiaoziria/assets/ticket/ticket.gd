class_name ticketData
extends Node2D

enum ImageType {
	ICON,
	FRAME,
	FULL
}
@export_group("Ticket Info")
@export var ticketID: int = 0
@export var ownerID: int = 0

@export_group("Filling")
@export var filling1: OrderData.FillingType = OrderData.FillingType.NONE
@export var filling2: OrderData.FillingType = OrderData.FillingType.NONE

@export_group("Cooking")
@export var cookingTime: int = 0
@export var cookingMethod: OrderData.CookingMethod = OrderData.CookingMethod.NONE

@export_group("Sauce 1")
@export var sauce1Base: OrderData.SauceBase = OrderData.SauceBase.NONE
@export var sauce1Addition1: OrderData.SauceAddition = OrderData.SauceAddition.NONE
@export var sauce1Addition2: OrderData.SauceAddition = OrderData.SauceAddition.NONE
@export var sauce1Addition3: OrderData.SauceAddition = OrderData.SauceAddition.NONE

@export_group("Sauce 2")
@export var sauce2Base: OrderData.SauceBase = OrderData.SauceBase.NONE
@export var sauce2Addition1: OrderData.SauceAddition = OrderData.SauceAddition.NONE
@export var sauce2Addition2: OrderData.SauceAddition = OrderData.SauceAddition.NONE
@export var sauce2Addition3: OrderData.SauceAddition = OrderData.SauceAddition.NONE

@export_group("Sauce 3")
@export var sauce3Base: OrderData.SauceBase = OrderData.SauceBase.NONE
@export var sauce3Addition1: OrderData.SauceAddition = OrderData.SauceAddition.NONE
@export var sauce3Addition2: OrderData.SauceAddition = OrderData.SauceAddition.NONE
@export var sauce3Addition3: OrderData.SauceAddition = OrderData.SauceAddition.NONE

func _get_image_path(filling: OrderData.FillingType, imageType: ImageType) -> String:
	return "res://assets/fillings/%s/%s.png" % [OrderData.FillingType.keys()[filling].to_lower(), ImageType.keys()[imageType].to_lower()]

func _set_filling_on_ticket(filling: OrderData.FillingType, fillingNumber: int):
	# find the filling node and set the texture to the filling type
	var fillingNode = get_node("Filling%dBase" % fillingNumber)
	var fillingIconNode = get_node("Filling%dIcon" % fillingNumber)
	# print("Filling node: ", fillingNode)
	if fillingNode == null:
		printerr("Invalid filling number passed to Ticket: " + str(fillingNumber))

	# set the modulate of the filling node to the correct color for that filling
	var filling_graphics = {
		OrderData.FillingType.PORK: {
			"color": Color(1, 0.8353, 0.8431),
			"image": _get_image_path(OrderData.FillingType.PORK, ImageType.ICON)
			},
		OrderData.FillingType.CABBAGE: {
			"color": Color(0.8549, 1.0, 0.7451),
			"image": _get_image_path(OrderData.FillingType.CABBAGE, ImageType.ICON)
			},
		OrderData.FillingType.SCALLION: {
			"color": Color(0.8039, 0.9333, 0.6392),
			"image": _get_image_path(OrderData.FillingType.SCALLION, ImageType.ICON)
			},
		OrderData.FillingType.CHIVE: {
			"color": Color(0.5961, 0.9255, 0.4314),
			"image": _get_image_path(OrderData.FillingType.CHIVE, ImageType.ICON)
			},
		OrderData.FillingType.SHRIMP: {
			"color": Color(1.0, 0.6627, 0.4941),
			"image": _get_image_path(OrderData.FillingType.SHRIMP, ImageType.ICON)
			},
		OrderData.FillingType.CHICKEN: {
			"color": Color(1.0, 0.5608, 0.4745),
			"image": _get_image_path(OrderData.FillingType.CHICKEN, ImageType.ICON)
			},
		OrderData.FillingType.MUSHROOM: {
			"color": Color(0.7294, 0.5412, 0.4471),
			"image": _get_image_path(OrderData.FillingType.MUSHROOM, ImageType.ICON)
			},
		OrderData.FillingType.BEEF: {
			"color": Color(0.4784, 0.4275, 0.4235),
			"image": _get_image_path(OrderData.FillingType.BEEF, ImageType.ICON)
			},
		OrderData.FillingType.TOFU: {
			"color": Color(0.7882, 0.6627, 0.4902),
			"image": _get_image_path(OrderData.FillingType.TOFU, ImageType.ICON)
			},
		OrderData.FillingType.KIMCHI: {
			"color": Color(1.0, 0.6157, 0.4745),
			"image": _get_image_path(OrderData.FillingType.KIMCHI, ImageType.ICON)
			},
		OrderData.FillingType.ORPHEUS: {
			"color": Color(0.6745, 0.8902, 1.0),
			"image": _get_image_path(OrderData.FillingType.ORPHEUS, ImageType.ICON)
			},
		OrderData.FillingType.NONE: {
			"color": Color(0.8784, 0.8784, 0.8784),
			"image": _get_image_path(OrderData.FillingType.NONE, ImageType.ICON)
			}
	}

	if filling in filling_graphics:
		if filling == OrderData.FillingType.NONE and fillingNumber == 1:
			printerr("Cannot set filling 1 to none!")
			return
		fillingNode.modulate = filling_graphics[filling]["color"]
		fillingIconNode.texture = load(filling_graphics[filling]["image"])
		fillingIconNode.scale = Vector2(0.11, 0.11)
	else:
		printerr("Invalid filling type passed to Ticket: " + str(OrderData.FillingType.keys()[filling]))
		return

func _set_cooking_method(method: OrderData.CookingMethod):
	var cookingMethodNode = $CookingMethod
	var cookingMethodTextures = {
		OrderData.CookingMethod.BOIL: preload("res://assets/ticket/cook-pot.svg"),
		OrderData.CookingMethod.FRY: preload("res://assets/ticket/cook-pan.svg")
	}
	print(OrderData.CookingMethod)

	if method in cookingMethodTextures:
		cookingMethodNode.texture = cookingMethodTextures[method]
		print(cookingMethod)
	else:
		print("Invalid cooking method passed to Ticket: ", OrderData.CookingMethod.keys()[method])
		if method == OrderData.CookingMethod.NONE:
			print("Tip: Cooking method is set to NONE, this should not happen. Perhaps you instantiated a ticket without a cooking method?")
		return
	# print("Cooking method set to: ", cookingMethod)

func _set_clock_target(target: int) -> void:
	var clockNode = $ClockBase/ClockHand
	var clockRotation = 0.0
	if target in range(8):
		clockRotation = target * 0.125 * PI
	else:
		printerr("Invalid clock target passed to Ticket: ", target)
		return
	clockNode.rotation = clockRotation
	# print("Clock target set to: ", target)
	# print("Clock rotation set to: ", clockRotation)
	return

func _set_sauce_base(number: int, sauceBase: OrderData.SauceBase):
	var sauceNode = get_node("Sauce%dBase" % number)
	if sauceNode == null:
		printerr("Invalid sauce number passed to Ticket: ", number)
		return

	if sauceBase == OrderData.SauceBase.NONE and number == 1:
		print("Sauce base 1 is NONE. This usually should not happen.")

	var sauce_colors = {
		OrderData.SauceBase.SOY_SAUCE: Color(0.5, 0.5, 1),
		OrderData.SauceBase.VINEGAR: Color(1, 0.5, 0.5),
		OrderData.SauceBase.GARLIC_OIL: Color(1, 1, 0),
		OrderData.SauceBase.SESAME_OIL: Color(1, 0.5, 0),
		OrderData.SauceBase.CHILI_OIL: Color(1, 0.5, 0),
		OrderData.SauceBase.NONE: Color(1, 1, 1)
	}

	if sauceBase in sauce_colors:
		sauceNode.modulate = sauce_colors[sauceBase]
		print("Sauce base set to: ", OrderData.SauceBase.keys()[sauceBase])
	else:
		printerr("Invalid sauce base passed to Ticket: ", OrderData.SauceBase.keys()[sauceBase])

func _set_sauce_addition(sauceNumber: int, additionNumber: int, addition: OrderData.SauceAddition):
	var sauceNode = get_node("Sauce%dBase" % sauceNumber)
	if sauceNode == null:
		printerr("Invalid sauce number passed to Ticket: ", sauceNumber)
		return

	var sauceAdditionNode = sauceNode.get_node("Sauce%dAdd%d" % [sauceNumber, additionNumber])
	if sauceAdditionNode == null:
		push_error("Invalid addition number passed to Ticket: " + str(additionNumber))
		return

	var addition_colors = {
		OrderData.SauceAddition.GARLIC: Color(1, 1, 0),
		OrderData.SauceAddition.GINGER: Color(1, 0.5, 0),
		OrderData.SauceAddition.SCALLION: Color(0.5, 1, 0.5),
		OrderData.SauceAddition.SESAME_SEED: Color(1, 1, 0),
		OrderData.SauceAddition.CHILI: Color(1, 0.5, 0),
		OrderData.SauceAddition.NONE: Color(1, 1, 1)
	}

	if addition in addition_colors:
		sauceAdditionNode.modulate = addition_colors[addition]
	else:
		printerr("Invalid sauce addition passed to Ticket: ", OrderData.SauceAddition.keys()[addition])

func set_ticket_info(ticket_info: OrderData):
	ticketID = ticket_info.ticketID
	ownerID = ticket_info.ownerID
	filling1 = ticket_info.fillings[0]
	print(filling1)
	cookingTime = ticket_info.cookingTime
	cookingMethod = ticket_info.cookingMethod
	sauce1Base = ticket_info.sauce1["base"]
	sauce1Addition1 = ticket_info.sauce1["addition1"]
	Global.ingred = {
		"cm": cookingMethod,
		"s": sauce1Base,
		"si": sauce1Addition1,
		"f": filling1
	}

func _ready():
	var ticketIDLabel = $TicketI
	ticketIDLabel.text = "HC" + str(ticketID)
	ticketButton.set_process_input(false)
	ticketButton.set_process(false)
	original_position = position
	_set_cooking_method(cookingMethod)
	_set_filling_on_ticket(filling1, 1)
	_set_filling_on_ticket(filling2, 2)
	_set_clock_target(cookingTime)
	for i in range(1, 4):
		_set_sauce_base(i, self.get("sauce%dBase" % i))
		for j in range(1, 4):
			_set_sauce_addition(i, j, self.get("sauce%dAddition%d" % [i, j]))
	print("Ticket ready, ID: ", ticketID)

# ----------------------------
#   Ticket Line Interactions
# ----------------------------

# follow mouse when dragging
var dragging = false
var drag_offset = Vector2()
var drag_active = false

var original_position = Vector2(960, 540)  # Default position
@onready var ticketButton = $TextureButton
@onready var animationPlayer = $AnimationPlayer
var areasTouched = []
var ticketLineY = 38
var lineHookCoords = Vector2(1680, ticketLineY)  # Set this to the desired coordinates

# when mouse held down on the ticket
func _on_texture_button_button_down():
	dragging = true
	drag_offset = get_global_mouse_position() - position
	# print("Ticket pressed, dragging started")

func _process(_delta):
	if dragging:
		position = get_global_mouse_position() - drag_offset

# when mouse released
func _on_texture_button_button_up():
	dragging = false
	# print("Ticket released, dragging stopped")
	var successfulSnap = false

	if "LineHookArea2D" in areasTouched:
		position = lineHookCoords
		original_position = lineHookCoords
		successfulSnap = true
		if scale < Vector2(1, 1):
			animationPlayer.play("grow")
	elif "TicketLineArea2D" in areasTouched:
		position.y = ticketLineY
		original_position = Vector2(position.x, ticketLineY)  # Update original position
		if scale > Vector2(1, 1):
			animationPlayer.play("shrink_smaller")
		successfulSnap = true

	if !successfulSnap:
		position = original_position

func _on_ticket_area_2d_area_entered(area: Area2D) -> void:
	# add the area to the list of touched areas
	areasTouched.append(area.name)
	if area.name == "LineArea2D":
		animationPlayer.play("shrink_smaller")
		scale = Vector2(1, 1)

func _on_ticket_area_2d_area_exited(area: Area2D) -> void:
	# remove the area from the list of touched areas
	areasTouched.erase(area.name)
	match area.name:
		"LineArea2D":
			animationPlayer.play("grow_smaller")
		"LineHookArea2D":
			if !dragging:
				animationPlayer.play("shrink")
