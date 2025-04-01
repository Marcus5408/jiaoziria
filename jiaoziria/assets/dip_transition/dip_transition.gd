extends Node2D

@onready var animationPlayer = $AnimationPlayer

func _on_main_animate_dip_from_black() -> void:
    animationPlayer.play("dip_from_black")

func _on_main_animate_dip_to_black() -> void:
    animationPlayer.play("dip_to_black")
