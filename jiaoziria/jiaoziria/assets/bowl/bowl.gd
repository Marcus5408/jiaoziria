class_name Bowl
extends Node2D

@export var bowlColor: Color
@onready var BowlBack = $BowlBack
@onready var BowlFront = $BowlFront

func _ready() -> void:
    BowlBack.modulate(bowlColor)
    BowlFront.modulate(bowlColor)