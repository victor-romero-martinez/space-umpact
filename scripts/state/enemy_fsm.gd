@icon("res://assets/icons/tools.svg")
extends Node
## [color=GREEN]State machine manager[/color]
class_name EnemyStateMachine

@export var state: State


func _ready():
	change_state(state)
	

## Set new state
func change_state(new_state: State):
	if state is State:
		state.exit_state()
	
	new_state.enter_state()
	state = new_state


## Actual state
func current_state() -> State:
	return state
