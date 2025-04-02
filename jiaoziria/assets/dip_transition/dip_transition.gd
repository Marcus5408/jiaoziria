extends Node2D
class_name DipTransition

@onready var animationPlayer = $AnimationPlayer

func _ready():
    self.visible = false
    animationPlayer.animation_finished.connect(_on_animation_finished)

func _process(_delta):
    match Main.transitionState:
        Main.TransitionStates.DIP:
            _screen_dip_to_black()
        Main.TransitionStates.RISE:
            _screen_dip_from_black()

func _screen_dip_from_black() -> void:
    self.visible = true
    self.move_to_front()
    animationPlayer.play("fade_from_black")

func _screen_dip_to_black() -> void:
    self.visible = true
    self.move_to_front()
    animationPlayer.play("fade_to_black")

func _on_animation_finished(anim_name):
    match anim_name:
        "fade_to_black":
            Main.transitionState = Main.TransitionStates.BLACK
        "fade_from_black":
            Main.transitionState = Main.TransitionStates.IDLE
            self.visible = false
