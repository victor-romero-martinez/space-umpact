extends EnemyAttack
## Enemy attack by bullet
class_name EnemyShots


@export var actor: Enemy
@export var bullet_scene: PackedScene


func _ready():
	set_physics_process(false)
	actor.on_viewport.connect(active_physics)
	

func enter_state():
	set_physics_process(true)
	var bullet = bullet_scene.instantiate()
	bullet.position = actor.position + Vector2(-16.0, 0)
	bullet.go_negative()

	actor.add_sibling(bullet)
	
	end_attack.emit()


func exite_state():
	set_physics_process(false)
	
	
func active_physics():
	set_physics_process(true)
