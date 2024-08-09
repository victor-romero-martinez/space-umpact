extends EnemyAttack
## Boss attack by bullet
class_name BossShots


@export var actor: Enemy
@export var bullet_scene: PackedScene

var _initial: float

func _ready():
	set_physics_process(false)
	actor.on_viewport.connect(active_physics)
	

func enter_state():
	set_physics_process(true)
	_initial = actor.position.x

	var rand_y = randf_range(-8, 8) #y = -2
	var position = actor.position
	position.x -= 16.0
	position.y += rand_y
	
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	bullet.go_negative()

	actor.add_sibling(bullet)
	
	end_attack.emit()


func exite_state():
	set_physics_process(false)
	
	
func active_physics():
	set_physics_process(true)
