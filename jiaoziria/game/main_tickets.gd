extends Control

const Ticket = preload("res://assets/ticket/ticket.tscn")

var ticketsList = []
var globalTicketID: int = 0

# check if 0 is pressed
func _input(event):
    if event is InputEventKey and event.is_action_pressed("dev_spawn_customer"):
        spawn_ticket()

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

func spawn_ticket():
    var available_fillings = FillingType.values()
    var available_cooking = CookingMethod.values()
    var available_bases = SauceBase.values()
    var available_additions = SauceAddition.values()

    var new_ticket_info = {
        "ticketID": globalTicketID,
        "filling1": available_fillings[randi() % (available_fillings.size() - 1)],
        "filling2": available_fillings[randi() % available_fillings.size()],
        "cookingMethod": available_cooking[randi() % (available_cooking.size() - 1)],
        "sauce1": {
            "base": available_bases[randi() % (available_bases.size() -1 )],
            "addition1": available_additions[randi() % available_additions.size()],
            "addition2": available_additions[randi() % available_additions.size()],
            "addition3": available_additions[randi() % available_additions.size()],
        },
        "sauce2": {
            "base": available_bases[randi() % (available_bases.size())],
            "addition1": available_additions[randi() % available_additions.size()],
            "addition2": available_additions[randi() % available_additions.size()],
            "addition3": available_additions[randi() % available_additions.size()],
        },
        "sauce3": {
            "base": available_bases[randi() % (available_bases.size())],
            "addition1": available_additions[randi() % available_additions.size()],
            "addition2": available_additions[randi() % available_additions.size()],
            "addition3": available_additions[randi() % available_additions.size()],
        },
    }
    globalTicketID += 1
    var ticket = Ticket.instantiate()
    ticket.set_ticket_info(new_ticket_info)
    ticket.position = Vector2(120, ticket.ticketLineY)
    ticketsList.append(new_ticket_info)
    add_child(ticket)
