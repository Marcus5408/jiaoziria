extends Node

var store_open = true
var store_closing_time = 60.0
var store_timer

var customer_count = 0
var customers = []
# customers are stored as a list of dictionaries
var customer_rating = {
    "ordering": 0,
    "preparing": 0,
    "cooking": 0,
    "saucing": 0,
    "waiting": 0,
}

var player_level = 0
var player_exp = 0
var player_tips = 0
var player_money = 0

var restaurant_rating = 0.00

var current_scene = "order"

func _ready():
    print("Hello, world!")
    # Initialize the store
    open_store()

func open_store():
    store_open = true
    # start store timer
    store_closing_time = 60.0
    store_timer = Timer.new()
    store_timer.wait_time = store_closing_time
    store_timer.timeout.connect(_on_store_timer_timeout)
    add_child(store_timer)
    store_timer.start()

    print("Store is open")

func _on_store_timer_timeout() -> void:
    store_open = false
    print("Store is closed")

func spawn_customer():
    var customer_scene = preload("res://game/customer/customer.tscn")
    var customer_instance = customer_scene.instance()
    add_child(customer_instance)
    customers.append(customer_instance)
    print("Spawning a new customer")
