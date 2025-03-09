extends Node2D

# detect if ticket collides with $TicketLine/Area2D/CollisionShape2D
func _on_area_2d_area_entered(area:Area2D) -> void:
    if area.name == "TicketArea2D":
        print("Ticket line entered, " + area.name)
    else:
        print("Ticket line not entered")

func _on_area_2d_area_exited(area:Area2D) -> void:
    if area.name == "TicketArea2D":
        print("Ticket line exited")
    else:
        print("Ticket line not exited, " + area.name)

func _process(_delta: float) -> void:
    # check if ticket line is active
    return
