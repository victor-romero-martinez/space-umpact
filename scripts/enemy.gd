extends CharacterBody2D

''' This script is only for Enemy node.
	- Use actors.tscn to inherited scene located in res://entities/actors.tscn
	- Attach dragging in your Enemy node.
'''

@export var speed: float = 0.0
@export var shoot: bool = false
@export var zigzag: bool = false
@export var to_down: bool = false
@export var zigzag_speed: float = 8.0
@export var explotion_scene: PackedScene
@export var bullet_scene: PackedScene

#WARNING: must be initialite before use on _make_bullets
@onready var screen_size: Vector2 = Global.screen_size

var _open_fire: float
var _is_on_zigzag: bool = false


func _ready():
	_open_fire = screen_size.x - 60


func _physics_process(_delta):
	if global_position.x < 0:
		queue_free()
	
	$AnimatedSprite2D.play("default")
	_apply_movement()
	_shooting()
	
	
	
func _apply_movement():
	if speed > 0: velocity.x = -speed
	if _is_on_zigzag: _apply_zigzag()
	
	move_and_slide()


func make_boom():
	if not explotion_scene:
		push_error('Explotion PackScene is missing')
	else:
		var boom = explotion_scene.instantiate()
		boom.position = position
		add_sibling(boom)
		
		queue_free()


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


func handle_zigzag_direction():
	to_down = not to_down

func _apply_zigzag():
	# switch direction on up or down
	var dir = 1 if to_down else -1
	velocity.y = zigzag_speed * dir
	


func start_move_on_zigszag():
	if zigzag:
		_is_on_zigzag = true


