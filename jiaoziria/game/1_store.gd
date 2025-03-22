extends Control

var store_open = true
var store_closing_time = 60.0
var store_timer
var customer_timer
var customer_count = 0

func _ready():
    customer_timer = Timer.new()
    customer_timer.wait_time = 5.0
    add_child(customer_timer)
    customer_timer.start()

func open_store():
    store_open = true
    # start store timer
    store_closing_time = 60.0
    store_timer = Timer.new()
    store_timer.wait_time = store_closing_time
    store_timer.timeout.connect(_on_store_timer_timeout)

    customer_timer.wait_time = 5.0
    customer_timer.start()
    print("Store is open")

func close_store():
    store_open = false
    customer_timer.stop()

func _on_order_pressed():
    print("Order button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/1-order.tscn")

func _on_prepare_pressed() -> void:
    print("Prep button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/2-prep.tscn")

func _on_cook_pressed() -> void:
    print("Cook button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/3-cook.tscn")

func _on_sauce_pressed() -> void:
    print("Sauce button pressed, attempting to change scene")
    get_tree().change_scene_to_file("res://game/4-sauce.tscn")

func _on_timer_timeout() -> void:
    # spawn a new customer
    if store_open:
        var customer_scene = preload("res://assets/customer/customer.tscn")
        var customer_instance = customer_scene.instance()
        add_child(customer_instance)
        print("Spawning a new customer")

func _on_store_timer_timeout() -> void:
    close_store()
    print("Store is closed")

func _on_order_station_add_new_customer(new_customer_data: Variant) -> void:
    var asset = new_customer_data.characterResource.asset
    var customer_instance = asset.instantiate()
    add_child(customer_instance)
    customer_instance.position = Vector2(400 + (110 * (Main.globalCustomerCount - 2)), 1000)
