extends Node

var ingred = {
	"cm": null,
	"s": null,
	"si": null,
	"f": null
}
var score = 0
var full = false
var one = false
var two = false
var three = false
var awawa = false
func reset():
	score = 0
	one = false
	two = false
	three = false
	awawa = false
	var root = get_tree().get_root()
	get_tree().change_scene_to_file("res://game/2-prep-station/main.tscn")
	if root.get_child_count() > 0:
		for child in root.get_children():
			child.queue_free()
	get_tree().change_scene_to_file("res://game/1-order-station/1-store.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
