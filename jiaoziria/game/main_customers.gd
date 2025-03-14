extends Node2D

func _input(event):
    if event is InputEventKey and event.is_action_pressed("dev_spawn_customer"):
        spawn_random_customer()

func spawn_random_customer():
    Main.globalCustomerCount += 1
    var new_customer = {
        "id" = Main.globalCustomerCount,
        
    }
    return
