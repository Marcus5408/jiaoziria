extends Node2D

const Ticket = preload("res://assets/ticket/ticket.tscn")

var ticketsList = []

# check if 0 is pressed
func _input(event):
    if event is InputEventKey and event.is_action_pressed("dev_spawn_random_ticket"):
        spawn_random_ticket()

func spawn_random_ticket():
    var available_fillings = OrderData.FillingType.values()
    var available_cooking = OrderData.CookingMethod.values()
    var available_bases = OrderData.SauceBase.values()
    var available_additions = OrderData.SauceAddition.values()

    var new_ticket_info = OrderData.new()
    Main.globalTicketID += 1
    new_ticket_info.ticketID = Main.globalTicketID
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
    spawn_ticket(new_ticket_info)
    print("Spawned random ticket")

func spawn_ticket(ticket_info: OrderData):
    var ticket = Ticket.instantiate()
    ticket.set_ticket_info(ticket_info)
    ticket.position = Vector2(120, ticket.ticketLineY)
    ticketsList.append(ticket_info)
    add_child(ticket)
