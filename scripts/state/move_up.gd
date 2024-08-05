extends State
class_name EnemyMoveUp


## active for move
@export var max_move: float = 0.0
@export var actor: Enemy

signal end_move_up

var to_positon_y: float

func _ready():
	set_physics_process(false)
	actor.on_viewport.connect(active_physics)
	to_positon_y = actor.global_position.y - max_move
	

func enter_state():
	actor.velocity.y = -actor.speed
	actor.velocity.x = 0


func exit_state():
	set_physics_process(false)


func _physics_process(_delta):
	if actor.global_position.y < to_positon_y:
		end_move_up.emit()
	
	actor.move_and_slide()

	

func active_physics():
	set_physics_process(true)
