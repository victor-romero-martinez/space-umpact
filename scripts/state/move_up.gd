extends State
class_name EnemyMoveUp


## active for move
@export var max_move: float = 0.0
## Enemy attack by bullet
@export var actor: Enemy

signal end_move_up


func _ready():
	set_physics_process(false)
	

func enter_state():
	set_physics_process(true)
	actor.velocity = Vector2(0, -actor.speed)


func exit_state():
	set_physics_process(false)


func _physics_process(_delta):
	if actor.global_position.y < max_move:
		end_move_up.emit()
	
	actor.move_and_slide()

	
