extends Node2D

const Ticket = preload("res://assets/ticket/ticket.tscn")

var ticketsList = []
var globalTicketID: int = 0

# check if 0 is pressed
func _input(event):
    if event is InputEventKey and event.is_action_pressed("dev_spawn_random_ticket"):
        spawn_ticket()

func spawn_ticket():
    var available_fillings = OrderData.FillingType.values()
    var available_cooking = OrderData.CookingMethod.values()
    var available_bases = OrderData.SauceBase.values()
    var available_additions = OrderData.SauceAddition.values()

    var new_ticket_info = OrderData.new()
    new_ticket_info.ticketID = globalTicketID
    new_ticket_info.ownerID = 0
    new_ticket_info.fillings = [
        available_fillings[randi() % (available_fillings.size() - 1)],
        available_fillings[randi() % available_fillings.size()],
    ]
    new_ticket_info.cookingTime = randi() % 8 # random cooking time between 1 and 10
    new_ticket_info.cookingMethod = available_cooking[randi() % (available_cooking.size() - 1)]
    
    new_ticket_info.sauce1 = {
        "base": available_bases[randi() % (available_bases.size() -1 )],
        "addition1": available_additions[randi() % available_additions.size()],
        "addition2": available_additions[randi() % available_additions.size()],
        "addition3": available_additions[randi() % available_additions.size()],
    }
    new_ticket_info.sauce2 = {
        "base": available_bases[randi() % (available_bases.size())],
        "addition1": available_additions[randi() % available_additions.size()],
        "addition2": available_additions[randi() % available_additions.size()],
        "addition3": available_additions[randi() % available_additions.size()],
    }
    new_ticket_info.sauce3 = {
        "base": available_bases[randi() % (available_bases.size())],
        "addition1": available_additions[randi() % available_additions.size()],
        "addition2": available_additions[randi() % available_additions.size()],
        "addition3": available_additions[randi() % available_additions.size()],
    }
    globalTicketID += 1
    var ticket = Ticket.instantiate()
    ticket.set_ticket_info(new_ticket_info)
    ticket.position = Vector2(120, ticket.ticketLineY)
    ticketsList.append(new_ticket_info)
    add_child(ticket)
