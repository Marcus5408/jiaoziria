extends Node2D

@export_group("Ticket Info")
@export var ticketID: int = 0
@export var ticketIdentifier: String = ""

@export_group("Filling")
@export var filling1: FillingType = FillingType.PORK
@export var filling2: FillingType = FillingType.CABBAGE

@export_group("Cooking")
@export var clockTarget: int = 0
@export var cookingMethod: CookingMethod = CookingMethod.BOIL

@export_group("Sauce 1")
@export var sauce1Base: SauceBase = SauceBase.SOY_SAUCE
@export var sauce1Addition1: SauceAddition = SauceAddition.GINGER
@export var sauce1Addition2: SauceAddition = SauceAddition.SCALLION
@export var sauce1Addition3: SauceAddition = SauceAddition.GINGER

@export_group("Sauce 2")
@export var sauce2Base: SauceBase = SauceBase.SOY_SAUCE
@export var sauce2Addition1: SauceAddition = SauceAddition.GINGER
@export var sauce2Addition2: SauceAddition = SauceAddition.SCALLION
@export var sauce2Addition3: SauceAddition = SauceAddition.GINGER

@export_group("Sauce 3")
@export var sauce3Base: SauceBase = SauceBase.SOY_SAUCE
@export var sauce3Addition1: SauceAddition = SauceAddition.GINGER
@export var sauce3Addition2: SauceAddition = SauceAddition.SCALLION
@export var sauce3Addition3: SauceAddition = SauceAddition.GINGER

# fillingType type
enum FillingType {
    PORK,
    CABBAGE,
    SCALLION,
    CHIVE,
    SHRIMP,
    CHICKEN,
    MUSHROOM,
    BEEF,
    TOFU,
    KIMCHI,
    ORPHEUS,
    NONE
}

enum CookingMethod {
    BOIL,
    FRY,
    NONE
}

enum SauceBase {
    SOY_SAUCE,
    VINEGAR,
    GARLIC_OIL,
    SESAME_OIL,
    CHILI_OIL,
    NONE
}

enum SauceAddition {
    GARLIC,
    GINGER,
    SCALLION,
    SESAME_SEED,
    CHILI,
    NONE
}

enum ImageType {
    ICON,
    FRAME,
    FULL
}

func _get_image_path(filling: FillingType, imageType: ImageType) -> String:
    return "res://assets/fillings/%s/%s.png" % [FillingType.keys()[filling], ImageType.keys()[imageType]]

func _set_filling_on_ticket(filling: FillingType, fillingNumber: int):
    # find the filling node and set the texture to the filling type
    var fillingNode = get_node("Filling%dBase" % fillingNumber)
    var fillingIconNode = get_node("Filling%dIcon" % fillingNumber)
    print("Filling node: ", fillingNode)
    if fillingNode == null:
        printerr("Invalid filling number passed to Ticket: " + str(fillingNumber))

    # set the modulate of the filling node to the correct color for that filling
    var filling_graphics = {
        FillingType.PORK: {
            "color": Color(1.0, 0.8353, 0.8431),
            "image": _get_image_path(FillingType.PORK, ImageType.ICON)
            },
        FillingType.CABBAGE: {
            "color": Color(0.5, 1, 0.5),
            "image": _get_image_path(FillingType.CABBAGE, ImageType.ICON)
            },
        FillingType.SCALLION: {
            "color": Color(0.5, 1, 0.5),
            "image": _get_image_path(FillingType.SCALLION, ImageType.ICON)
            },
        FillingType.CHIVE: {
            "color": Color(0.5, 1, 0.5),
            "image": _get_image_path(FillingType.CHIVE, ImageType.ICON)
            },
        FillingType.SHRIMP: {
            "color": Color(1, 0.5, 0.5),
            "image": _get_image_path(FillingType.SHRIMP, ImageType.ICON)
            },
        FillingType.CHICKEN: {
            "color": Color(1, 0.5, 0.5),
            "image": _get_image_path(FillingType.CHICKEN, ImageType.ICON)
            },
        FillingType.MUSHROOM: {
            "color": Color(0.5, 0.5, 1),
            "image": _get_image_path(FillingType.MUSHROOM, ImageType.ICON)
            },
        FillingType.BEEF: {
            "color": Color(1, 0.5, 0.5),
            "image": _get_image_path(FillingType.BEEF, ImageType.ICON)
            },
        FillingType.TOFU: {
            "color": Color(1, 1, 1),
            "image": _get_image_path(FillingType.TOFU, ImageType.ICON)
            },
        FillingType.KIMCHI: {
            "color": Color(1, 0.5, 0.5),
            "image": _get_image_path(FillingType.KIMCHI, ImageType.ICON)
            },
        FillingType.ORPHEUS: {
            "color": Color(1, 0.5, 0.5),
            "image": _get_image_path(FillingType.ORPHEUS, ImageType.ICON)
            },
        FillingType.NONE: {
            "color": Color(1, 1, 1),
            "image": _get_image_path(FillingType.NONE, ImageType.ICON)
            }
    }

    if filling in filling_graphics:
        if filling == FillingType.NONE and fillingNumber == 1:
            printerr("Cannot set filling 1 to none!")
            return
        fillingNode.modulate = filling_graphics[filling]["color"]
        fillingIconNode.texture = load(filling_graphics[filling]["image"])
        fillingIconNode.scale = Vector2(0.11, 0.11)
    else:
        printerr("Invalid filling type passed to Ticket: " + str(FillingType.keys()[filling]))
        return

func _set_cooking_method(method: CookingMethod):
    var cookingMethodNode = $CookingMethod
    var cookingMethodTextures = {
        CookingMethod.BOIL: preload("res://assets/ticket/cook-pot.svg"),
        CookingMethod.FRY: preload("res://assets/ticket/cook-pan.svg")
    }

    if method in cookingMethodTextures:
        cookingMethodNode.texture = cookingMethodTextures[method]
    else:
        printerr("Invalid cooking method passed to Ticket: ", CookingMethod.keys()[method])
        if method == CookingMethod.NONE:
            printerr("Tip: Cooking method is set to NONE, this should not happen. Perhaps you instantiated a ticket without a cooking method?")
        return
    print("Cooking method set to: ", cookingMethod)

func _set_clock_target(target: int) -> void:
    var clockNode = $ClockBase/ClockHand
    var clockRotation = 0.0
    if target in range(8):
        clockRotation = target * 0.125 * PI
    else:
        printerr("Invalid clock target passed to Ticket: ", target)
        return
    clockNode.rotation = clockRotation
    print("Clock target set to: ", target)
    print("Clock rotation set to: ", clockRotation)
    return

func _set_sauce_base(number: int, sauceBase: SauceBase):
    var sauceNode = get_node("Sauce%dBase" % number)
    if sauceNode == null:
        printerr("Invalid sauce number passed to Ticket: ", number)
        return

    if sauceBase == SauceBase.NONE and number == 1:
        printerr("Cannot set sauce 1 base to none!")
        return

    var sauce_colors = {
        SauceBase.SOY_SAUCE: Color(0.5, 0.5, 1),
        SauceBase.VINEGAR: Color(1, 0.5, 0.5),
        SauceBase.GARLIC_OIL: Color(1, 1, 0),
        SauceBase.SESAME_OIL: Color(1, 0.5, 0),
        SauceBase.CHILI_OIL: Color(1, 0.5, 0),
        SauceBase.NONE: Color(1, 1, 1)
    }

    if sauceBase in sauce_colors:
        sauceNode.modulate = sauce_colors[sauceBase]
    else:
        printerr("Invalid sauce base passed to Ticket: ", SauceBase.keys()[sauceBase])

func _set_sauce_addition(sauceNumber: int, additionNumber: int, addition: SauceAddition):
    var sauceNode = get_node("Sauce%dBase" % sauceNumber)
    if sauceNode == null:
        printerr("Invalid sauce number passed to Ticket: ", sauceNumber)
        return

    var sauceAdditionNode = sauceNode.get_node("Sauce%dAdd%d" % [sauceNumber, additionNumber])
    if sauceAdditionNode == null:
        push_error("Invalid addition number passed to Ticket: " + str(additionNumber))
        return

    var addition_colors = {
        SauceAddition.GARLIC: Color(1, 1, 0),
        SauceAddition.GINGER: Color(1, 0.5, 0),
        SauceAddition.SCALLION: Color(0.5, 1, 0.5),
        SauceAddition.SESAME_SEED: Color(1, 1, 0),
        SauceAddition.CHILI: Color(1, 0.5, 0),
        SauceAddition.NONE: Color(1, 1, 1)
    }

    if addition in addition_colors:
        sauceAdditionNode.modulate = addition_colors[addition]
    else:
        printerr("Invalid sauce addition passed to Ticket: ", SauceAddition.keys()[addition])

func set_ticket_info(ticket_info):
    ticketID = ticket_info.ticketID
    filling1 = ticket_info.filling1
    filling2 = ticket_info.filling2
    cookingMethod = ticket_info.cookingMethod
    sauce1Base = ticket_info.sauce1.base
    sauce1Addition1 = ticket_info.sauce1.addition1
    sauce1Addition2 = ticket_info.sauce1.addition2
    sauce1Addition3 = ticket_info.sauce1.addition3
    sauce2Base = ticket_info.sauce2.base
    sauce2Addition1 = ticket_info.sauce2.addition1
    sauce2Addition2 = ticket_info.sauce2.addition2
    sauce2Addition3 = ticket_info.sauce2.addition3
    sauce3Base = ticket_info.sauce3.base
    sauce3Addition1 = ticket_info.sauce3.addition1
    sauce3Addition2 = ticket_info.sauce3.addition2
    sauce3Addition3 = ticket_info.sauce3.addition3
    _ready()  # Call _ready to update the visuals

func _ready():
    var ticketIDLabel = $TicketID
    ticketIDLabel.text = "HC" + str(ticketID)
    if ticketIdentifier == "":
        # warning: ticketIdentifier is empty
        print("Warning: ticketIdentifier is empty!")
    else:
        print("Ticket identifier: ", ticketIdentifier)
    ticketButton.set_process_input(false)
    ticketButton.set_process(false)
    original_position = position
    _set_cooking_method(cookingMethod)
    _set_filling_on_ticket(filling1, 1)
    _set_filling_on_ticket(filling2, 2)
    _set_clock_target(clockTarget)
    for i in range(1, 4):
        _set_sauce_base(i, self.get("sauce%dBase" % i))
        for j in range(1, 4):
            _set_sauce_addition(i, j, self.get("sauce%dAddition%d" % [i, j]))
    print("Ticket ready, ID: ", ticketID)

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
    print("Ticket pressed, dragging started")

func _process(_delta):
    if dragging:
        position = get_global_mouse_position() - drag_offset

# when mouse released
func _on_texture_button_button_up():
    dragging = false
    print("Ticket released, dragging stopped")
    var successfulSnap = false

    if "LineHookArea2D" in areasTouched:
        position = lineHookCoords
        original_position = lineHookCoords
        successfulSnap = true
        if scale < Vector2(1, 1):
            animationPlayer.play("grow")
        print("Ticket moved to target position")
    elif "TicketLineArea2D" in areasTouched:
        position.y = ticketLineY
        original_position = Vector2(position.x, ticketLineY)  # Update original position
        if scale > Vector2(1, 1):
            animationPlayer.play("shrink_smaller")
        successfulSnap = true
        print("Ticket Y position set to", ticketLineY)

    if !successfulSnap:
        # If not successfully snapped to any area, return to original position
        position = original_position
        print("Ticket returned to original position")

func _on_ticket_area_2d_area_entered(area: Area2D) -> void:
    # add the area to the list of touched areas
    areasTouched.append(area.name)
    if area.name == "LineArea2D":
        print("Ticket area entered")
        animationPlayer.play("shrink_smaller")
        scale = Vector2(1, 1)
    else:
        print("Ticket area not entered")

func _on_ticket_area_2d_area_exited(area: Area2D) -> void:
    # remove the area from the list of touched areas
    areasTouched.erase(area.name)
    match area.name:
        "LineArea2D":
            print("Ticket area exited")
            animationPlayer.play("grow_smaller")
        "LineHookArea2D":
            if !dragging:
                print("Ticket area exited")
                animationPlayer.play("shrink")
        _:
            print("Ticket area not exited")
