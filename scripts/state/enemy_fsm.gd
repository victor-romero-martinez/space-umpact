@icon("res://assets/icons/tools.svg")
extends Node
## State machine manager
class_name EnemyStateMachine

@export var state: State

func _ready():
	change_state(state)
	

func change_state(new_state: State):
	if state is State:
		state.exit_state()
	
	new_state.enter_state()
	state = new_state
