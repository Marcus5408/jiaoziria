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
	print(new_ticket_info.cookingMethod)
	
	new_ticket_info.sauce1 = {
		"base": available_bases[randi() % (available_bases.size() -1 )],
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

signal order_taken(customerName: String)
func _on_store_view_customer_take_order_button_pressed(customerNodeData:Variant, customerName:String) -> void:
	await get_tree().create_timer(1).timeout

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
	# assign ticket info
	ticket.set_ticket_info(customerNodeData.order)
	add_child(ticket)

	var ticket_elements = [
		["Filling1Base", "Filling1Icon"], ["Filling2Base", "Filling2Icon"],
		"CookingMethod", "ClockBase"
	]
	# Hide elements
	for element in ticket_elements:
		if element is Array:
			for subelement in element:
				get_node("Ticket/" + subelement).hide()
		else:
			get_node("Ticket/" + element).hide()
		var sauce_base = get_node("Ticket/Sauce" + str(1) + "Base")
		sauce_base.hide()
		for j in range(1, 4):  # for additions 1, 2, 3
			sauce_base.get_node("Sauce" + str(1) + "Add" + str(j)).hide()
	
	# await DipTransitionScript.dip_from_black()
	Main.transitionState = Main.TransitionStates.RISE
	await get_tree().create_timer(Main.transitionTimer).timeout
	
	# slowly reveal elements
	await get_tree().create_timer(0.5).timeout
	for element in ticket_elements:
		if element is Array:
			for subelement in element:
				get_node("Ticket/" + subelement).show()
		else:
			get_node("Ticket/" + element).show()
		await get_tree().create_timer(0.5).timeout
		var sauce_base = get_node("Ticket/Sauce" + str(1) + "Base")
		if customerNodeData.order["sauce" + str(1)]["base"] == OrderData.SauceBase.NONE:
			continue
		sauce_base.show()
		await get_tree().create_timer(0.5).timeout
		for j in range(1, 4):  # for additions 1, 2, 3
			if customerNodeData.order["sauce" + str(1)]["addition" + str(j)] == OrderData.SauceAddition.NONE:
				continue
			sauce_base.get_node("Sauce" + str(1) + "Add" + str(j)).show()
			await get_tree().create_timer(0.5).timeout
	
	await get_tree().create_timer(2).timeout # just some extra time to look at the ticket
	# await DipTransitionScript.dip_to_black()
	Main.transitionState = Main.TransitionStates.DIP
	await get_tree().create_timer(Main.transitionTimer).timeout
	emit_signal("order_taken", customerName)
