extends Node2D
class_name LaserV

enum DIRECTION { LEFT, RIGTH }

@export var speed: float = 12.0
@export var direction: DIRECTION = DIRECTION.RIGTH


var taget: Area2D


func _process(delta):
	position.x += delta * (speed * direction)


func _apply_damage():
	taget.take_damage(3)
	


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
