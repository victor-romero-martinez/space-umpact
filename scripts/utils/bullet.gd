@icon("res://assets/icons/crossed-swords.svg")
extends StaticBody2D

enum DIRECTION { LEFT = -1, RIGTH = 1 }

@export var speed: float = 100.0
@export var direction: DIRECTION = DIRECTION.RIGTH

var limit = Global.screen_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += (speed * direction) * delta


#NOTE: using on enemy when shooting
func go_negative(spd: float = 40.0):
	direction = DIRECTION.LEFT
	speed = spd
	$BulletHitBox.set_collision_mask_value(3, false)
	$BulletHitBox.set_collision_mask_value(4, false)


func _on_area_2d_area_entered(area):
	if area is EnemyHealthBox or area is PlayerHealthBox:
		area.take_damage()
	
	queue_free()
