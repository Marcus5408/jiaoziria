extends Node

var scene_index = {
	"order": 0,
	"prep": 1,
	"cook": 2,
	"sauce": 3,
}
var station_width = 1920

func _ready():
	print("Hello, world!")
	self.set("separation", station_width)

func _set_new_station(station_name: String) -> void:
	# transition into
	Main.transitionState = Main.TransitionStates.DIP
	await get_tree().create_timer(Main.transitionTimer).timeout

	print("Station name is " + station_name)
	# station_name not in scene_index then printerr
	if not station_name in scene_index:
		printerr("Station name not in scene_index, resetting")
		station_name = "order"
	self.position = Vector2( - (station_width * scene_index[station_name]), 0)

	# transition out of
	Main.transitionState = Main.TransitionStates.RISE
	await get_tree().create_timer(Main.transitionTimer).timeout

func _on_station_changed_to_order() -> void:
	_set_new_station("order")

func _on_station_changed_to_prep() -> void:
	_set_new_station("prep")

func _on_station_changed_to_cook() -> void:
	_set_new_station("cook")

func _on_station_changed_to_sauce() -> void:
	_set_new_station("sauce")
