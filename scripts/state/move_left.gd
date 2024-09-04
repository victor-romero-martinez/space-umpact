extends State
class_name EnemyMoveLeft

signal end_move_left

## active for move
@export var max_move: float = 290.0
@export var actor: Enemy


func _ready():
	set_physics_process(false)
	

func enter_state():
	#set_physics_process(true)
	var t = create_tween()
	t.tween_property(actor, 'position:x', max_move, 2.0)
	t.tween_callback(_tween_end_move_left)


func exit_state():
	set_physics_process(false)


func _tween_end_move_left():
	end_move_left.emit()
	actor.activate_fight.emit()
	actor.set_health.emit(actor.health)
