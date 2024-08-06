extends State
class_name EnemyMoveLeft


## active for move
@export var max_move: float = 0.0
@export var actor: Enemy

signal end_move_left

var to_positon_x: float

func _ready():
	set_physics_process(false)
	to_positon_x = actor.global_position.x - max_move
	

func enter_state():
	#set_physics_process(true)
	var t = create_tween()
	t.tween_property(actor, 'position:x', to_positon_x, 2.0)
	t.tween_callback(_tween_end_move_left)


func exit_state():
	set_physics_process(false)


func _tween_end_move_left():
	end_move_left.emit()
	actor.activate_fight.emit()
	actor.set_health.emit(actor.health)



