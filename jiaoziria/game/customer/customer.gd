extends Node2D

func _ready():
    print("Customer arrived")
    # Add additional customer behavior here
    # hide button
    var button = $Button
    button.hide()

    