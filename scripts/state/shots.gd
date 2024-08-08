extends EnemyAttack
## Enemy attack by bullet
class_name EnemyShots

signal end_shot


@export var actor: Enemy
@export var bullet_scene: PackedScene

var _initial: float

func _ready():
	set_physics_process(false)
	actor.on_viewport.connect(active_physics)
	

func enter_state():
	set_physics_process(true)
	_initial = actor.global_position.x

	var rand_y = randf_range(-8, 8) #y = -2
	var g_position = actor.global_position
	g_position.x -= 16.0
	g_position.y += rand_y
	
	var bullet = bullet_scene.instantiate()
	bullet.position = g_position
	bullet.go_negative()

	actor.add_sibling(bullet)
	
	end_shot.emit()


func exite_state():
	set_physics_process(false)
	
	
func active_physics():
	set_physics_process(true)
