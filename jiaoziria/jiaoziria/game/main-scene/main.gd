extends Control

var globalTicketID: int = 0
var globalCustomerCount: int = 0
var globalCustomerDetails = {}
enum TransitionStates {
	IDLE,
	DIP,
	BLACK,
	RISE
}
@onready var root = get_tree().get_root()
var transitionState: TransitionStates
const transitionTimer: float = 0.1
func _process(delta):
	if(Global.awawa == true):
		Global.score = 0
		Global.one = false
		Global.two = false
		Global.three = false
		Global.awawa = false
		get_tree().change_scene_to_file("res://game/2-prep-station/main.tscn")
		
