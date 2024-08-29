@icon("res://assets/icons/crossed-swords.svg")
extends Node2D
class_name LaserV

enum DIRECTION { LEFT = -1, RIGTH = 1 }

@export var speed: float = 16.0
@export var direction: DIRECTION = DIRECTION.RIGTH

var taget: Area2D


func _process(delta):
	position.x += delta * (speed * direction)


func _apply_damage():
	taget.take_damage(3)
	

func go_negative(spd: float = 16.0):
	direction = DIRECTION.LEFT
	speed = spd
	$BulletHitBox.set_collision_mask_value(3, false)
	$BulletHitBox.set_collision_mask_value(4, false)


func _on_area_2d_area_entered(area):
	if area is EnemyHealthBox or area is PlayerHealthBox:
		taget = area
		_apply_damage()
		$Timer.start()


func _on_area_2d_area_exited(_area):
	taget = null
	$Timer.stop()


func _on_timer_timeout():
	_apply_damage()
