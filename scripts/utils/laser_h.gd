extends Node2D

@export var explotion_scene: PackedScene
@onready var global = Global

const SPEED = 400.0

var _target: Area2D

func _ready():
	%RayCast2D.target_position = Vector2(global.screen_size.x, 0)
	
	
func _process(_delta):
	if %RayCast2D.is_colliding():
		var collition_point = %RayCast2D.get_collision_point()
		%Line2D.points[1].x = global_position.distance_to(collition_point)
		%CollisionShape2D.position.x = global_position.distance_to(collition_point)
	else:
		%Line2D.points[1].x = global.screen_size.x


func _apply_damage():
	_target.take_damage(3)
	

func go_negative():
	rotation_degrees = 180


func _on_area_area_entered(area):
	if area is EnemyHealthBox or area is PlayerHealthBox:
		_target = area
		_apply_damage()
		$DamageTimer.start()
	

func _on_timer_timeout():
	_apply_damage()
	

func _on_distroyer_timeout():
	var explotion = explotion_scene.instantiate()
	explotion.position = global_position
	
	add_sibling(explotion)
	queue_free()


func _on_area_area_exited(_area):
	_target = null
	$DamageTimer.stop()

