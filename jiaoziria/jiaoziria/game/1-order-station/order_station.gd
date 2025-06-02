extends VBoxContainer

signal add_new_customer(new_customer_data)

var customerDetailsScript = preload("res://assets/customer/customer.gd")
const possibleCustomers = [
	{"id": 0, "name": "Alice", "picky": 0},
	{"id": 1, "name": "Bob", "picky": 0},
	{"id": 2, "name": "Charles", "picky": 0},
	{"id": 3, "name": "Diana", "picky": 0},
	{"id": 4, "name": "Eve", "picky": 0},
	{"id": 5, "name": "Frank", "picky": 0},
	{"id": 6, "name": "Grace", "picky": 0},
	{"id": 7, "name": "Heidi", "picky": 0},
	{"id": 8, "name": "Ivan", "picky": 0},
	{"id": 9, "name": "Judy", "picky": 0},
]
const possibleCustomersCount: int = 10

func _input(event):
	if event.is_action_pressed("dev_spawn_customer"):
		var temp_new_customer = add_random_customer()
		print("Added new customer: ", temp_new_customer.characterResource.name)
		emit_signal("add_new_customer", temp_new_customer)

func add_random_customer():
	# set the character data (pick randomly)
	var temp_new_character = CharacterData.new()
	# set to random character
	var random_character = randi() % possibleCustomersCount
	temp_new_character.id = possibleCustomers[random_character]["id"]
	temp_new_character.name = possibleCustomers[random_character]["name"]
	temp_new_character.pickiness = possibleCustomers[random_character]["picky"]

	var temp_new_order = OrderData.create()
	Main.globalTicketID += 1
	Main.globalCustomerCount += 1
	temp_new_order.ticketID = Main.globalTicketID
	temp_new_order.ownerID = Main.globalCustomerCount

	var temp_new_customer = customerDetailsScript.new()
	temp_new_customer.characterResource.id = Main.globalCustomerCount
	temp_new_customer.characterResource = temp_new_character
	temp_new_customer.order = temp_new_order

	# add the customer to the global customer data
	Main.globalCustomerDetails[Main.globalCustomerCount] = temp_new_customer
	return temp_new_customer


func _on_store_view_customer_take_order_button_pressed(customerNodeData: Variant, customerName: String) -> void:
	Main.transitionState = Main.TransitionStates.DIP
	await get_tree().create_timer(Main.transitionTimer).timeout
	# find the customer that triggered this and revoke their ordering privileges
	var customer = get_node("StoreView/Customer" + str(customerNodeData.characterResource.id))
	var customerButton = customer.get_node("Button")
	customerButton.hide()
	# move self up 1080 pixels
	self.position.y -= 1080
	# put the customer in the center of the customerView
	var customerView = get_node("StoreView/" + customerName)
	var customerAsset = customerNodeData.characterResource.asset
	customerView.add_child(customerAsset.instantiate())
	# hide get order button from the customerAsset
	var customerAssetNode = customerView.get_node("CustomerNode")
	customerAssetNode.get_node("Button").hide()


func _on_ticket_layer_order_taken(customerName: String) -> void:
	self.position.y += 1080
	var customerView = get_node("StoreView/" + customerName)
	var customerAssetNode = customerView.get_node("CustomerNode")
	customerAssetNode.position.y -= 60
	# move backwards the customer id z position
	customerAssetNode.z_index = -3

	Main.transitionState = Main.TransitionStates.RISE
	await get_tree().create_timer(Main.transitionTimer).timeout
