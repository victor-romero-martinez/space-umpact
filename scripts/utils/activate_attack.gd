extends ViewportDetector

## [b]Optional[/b] if you only want to activate the [u]Timer Attack[/u] leave the property empty.
@export var state_manager: EnemyStateMachine
## [b]Optional[/b] if you only want to activate the [u]Timer Attack[/u] leave the property empty.
@export var next_state: State

# Generally this method will be used by small enemies.
func do_something():
	if get_parent().has_method('start_timer'):
		get_parent().start_timer()
		
	if state_manager and next_state:
		state_manager.change_state(next_state)
