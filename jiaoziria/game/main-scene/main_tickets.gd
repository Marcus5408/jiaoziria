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

func _on_store_view_customer_take_order_button_pressed(customerNodeData:Variant, _customerName:String) -> void:
    # hide everything except $TicketLine
    var childNodes = get_children()
    for child in childNodes:
        if child.name != "TicketLine":
            child.hide()
    
    # add new ticket to the ticket line using the customerNodeData
    var ticket = Ticket.instantiate()
    var lineHookPosition = get_node("TicketLine/LineHookBg/").position
    print("New position: ", lineHookPosition)
    ticket.position = lineHookPosition
    ticket.scale = Vector2(1.5, 1.5)
    ticketsList.append(customerNodeData.order)
    # assign basic ticket info, like ticketID and ownerID
    ticket.ticketID = customerNodeData.order.ticketID
    ticket.ownerID = customerNodeData.order.ownerID
    add_child(ticket)
    get_node("Ticket/Filling1Base").hide()
    get_node("Ticket/Filling2Base").hide()
    get_node("Ticket/Filling1Icon").hide()
    get_node("Ticket/Filling2Icon").hide()
    get_node("Ticket/ClockBase").hide()
    get_node("Ticket/CookingMethod").hide()

    var order_data = customerNodeData.order

    await get_tree().create_timer(0.5).timeout
    # add fillings
    ticket.filling1 = order_data.fillings[0]
    get_node("Ticket/Filling1Base").show()
    await get_tree().create_timer(0.5).timeout
    ticket.filling2 = order_data.fillings[1]
    get_node("Ticket/Filling2Base").show()
    await get_tree().create_timer(0.5).timeout
    # add cooking method
    ticket.cookingMethod = order_data.cookingMethod
    get_node("Ticket/CookingMethod").show()
    await get_tree().create_timer(0.5).timeout
    # add cooking time
    ticket.cookingTime = order_data.cookingTime
    get_node("Ticket/ClockBase").show()
    await get_tree().create_timer(0.5).timeout
    # add sauce1
    for i in range(1, 4):  # for sauces 1, 2, 3
        var sauce = order_data.get("sauce" + str(i))
        ticket.set("sauce%d" % i, sauce["base"])
        await get_tree().create_timer(0.5).timeout
        
        for j in range(1, 4):  # for additions 1, 2, 3
            ticket.set("addition%d" % j, sauce["addition" + str(j)])
            await get_tree().create_timer(0.5).timeout
