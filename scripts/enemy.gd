extends CharacterBody2D
class_name Enemy

''' This script is only for Enemy node.
	- Use actors.tscn to inherited scene located in res://entities/actors.tscn
	- Attach dragging in your Enemy node.
'''

@export var healt: int = 1
@export var speed: float = 0.0
@export var shoot: bool = false
@export var zigzag: bool = false
@export var zigzag_speed: float = 20.0
@export var explotion_scene: PackedScene
@export var bullet_scene: PackedScene

#WARNING: must be initialite before use on _make_bullets
@onready var screen_size: Vector2 = Global.screen_size

var _open_fire = screen_size.x - 60


func _physics_process(_delta):
	if healt == 0:
		_make_boom()
		queue_free()
	
	if global_position.x < 0:
		queue_free()
	
	$AnimatedSprite2D.play("default")
	_apply_movement()
	_shooting()
	
	
func _apply_movement():
	if speed > 0:
		velocity.x = -speed
		move_and_slide()
	elif zigzag:
		_move_on_zigszag()
		move_and_slide()
		
	

func _make_boom():
	if not explotion_scene:
		push_error('Explotion PackScene is missing')
	else:
		var boom = explotion_scene.instantiate()
		boom.position = position
		add_sibling(boom)


func _make_bullets():
	if global_position.x < _open_fire:
		if not bullet_scene:
			push_error('Bullet PackScene is missing')
			shoot = false
		else:
			var bullet = bullet_scene.instantiate()
			bullet.go_negative()
			bullet.position = position + Vector2(-8.0, 0)
			add_sibling(bullet)
			
			shoot = false


func _shooting():
	if shoot:
		_make_bullets()


func _move_on_zigszag():
	if zigzag:
		velocity.y = zigzag_speed


#WARNING: don't forget to connected by signal for each instantiation
func _on_area_2d_body_entered(_body):
	healt -= 1
