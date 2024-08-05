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
	set_physics_process(true)
	actor.velocity.x = -actor.speed
	actor.velocity.y = 0


func exit_state():
	set_physics_process(false)


func _physics_process(_delta):
	if actor.global_position.x < to_positon_x:
		end_move_left.emit()
		# TODO: add type to enemy class
		actor.activate_fight.emit()
		actor.set_health.emit(actor.health)
	
	actor.move_and_slide()

