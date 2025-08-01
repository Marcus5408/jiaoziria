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
        for child in root.get_children():
            if child.has_meta("filename"):
                var scene_path = child.get_meta("filename")
                var scene = load(scene_path)
                var new_instance = scene.instantiate()
                root.remove_child(child)
                child.queue_free()
                root.add_child(new_instance)
