extends State
class_name DeadBoss


@export var actor: Enemy

@onready var global = Global

var off_viewport_y: float


func _ready():
	set_physics_process(false)
	off_viewport_y = global.screen_size.y + 20.0
	

func enter_state():
	set_physics_process(true)
	actor.velocity = Vector2(0, abs(actor.speed))
	
	
func _physics_process(_delta):
	if actor.position.y > off_viewport_y:
		global.queue_boss = true
		actor.queue_free()
		
	actor.move_and_slide()
	
	
func exit_state():
	set_physics_process(false)
