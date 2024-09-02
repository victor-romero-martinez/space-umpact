extends State
class_name Idle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func enter_state():
	set_physics_process(false)
	
	
func exit_state():
	set_physics_process(false)
