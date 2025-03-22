extends VBoxContainer

signal add_new_customer(new_customer_data)

var CustomerScript = preload("res://assets/customer/customer.gd")
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
    var temp_new_character = Character.new()
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

    var temp_new_customer = CustomerData.new()
    temp_new_customer.id = Main.globalCustomerCount
    temp_new_customer.characterResource = temp_new_character
    temp_new_customer.order = temp_new_order

    # add the customer to the global customer data
    Main.globalCustomerData[Main.globalCustomerCount] = temp_new_customer
    return temp_new_customer
