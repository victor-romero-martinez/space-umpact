extends ViewportDetector


@export var wait_time: float = 6.0
@export var state_manager: EnemyStateMachine
@export var activate_state: State


func do_something():
	var tmp = get_parent().speed
	get_parent().speed = 0 # NOTICE: this vector x
	_has_state()
	await get_tree().create_timer(wait_time).timeout
	get_parent().speed = tmp # NOTICE: restore original value
	

func _has_state():
	if state_manager and activate_state:
		state_manager.change_state(activate_state)
