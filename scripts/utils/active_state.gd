extends ViewportDetector


@export var state_manager: EnemyStateMachine
@export var next_state: State


func do_something():
	state_manager.change_state(next_state)
