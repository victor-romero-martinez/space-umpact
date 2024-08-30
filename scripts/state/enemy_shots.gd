extends EnemyAttack
## Enemy attack by bullet
class_name EnemyShots


## Entity owner
@export var actor: Enemy


func _ready():
	set_physics_process(false)
	

func enter_state():
	set_physics_process(true)
	
	actor.start_timer()
	end_attack.emit()


func exite_state():
	set_physics_process(false)
	
