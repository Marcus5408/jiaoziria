extends Control

var dumpling_skin_active = false

var red_filling = false

@onready var finishedDumplingButton = get_node("finishDumpling")
@onready var finishedDumplingImage = get_node("FinishedDumplingImage")
@onready var IngredientsSomething = get_node("Ingredients")

func filling_activate():
	finishedDumplingButton.visible = true
	red_filling = true

func dumpling_activate():
	dumpling_skin_active = true

func _on_finish_dumpling_pressed() -> void:
	if (red_filling == true and dumpling_skin_active == true):
		finishedDumplingImage.visible = true
		IngredientsSomething.visible = false
