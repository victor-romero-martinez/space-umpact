extends EnemyAttack
## Boss attack by bullet
class_name BossShots


@export var actor: Enemy


func _ready():
	set_physics_process(false)
	

func enter_state():
	set_physics_process(true)
	
	actor.make_bullet()
	end_attack.emit()



func exite_state():
	set_physics_process(false)
	
