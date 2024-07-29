@icon("res://assets/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/16x16/helmet_02e.png")
extends CharacterBody2D

@export var health: int = 60
## invincibility when in transition
@export var immunity: bool = true
@export var speed: float = 15.0
## activate up down movement
@export var zigzag_speed: float = 8.0
## initial movement by default is to up
@export var to_down: bool = false
@export var bullet_scene: PackedScene
## time elapsed between shots
@export var timer_shots: float = 2.0
@export var bullet_by_shots: int = 1
@export var explotion_scene: PackedScene

@onready var boss_collision = $CollisionShape2D

var _screen_size: Vector2
var _on_viewport: Vector2 = Vector2(155.0, 42.0)
var _offset_vieport: Vector2 = Vector2(197.0, 42.0)
var _can_shoot: bool = false
var _is_dead: bool = false


func _ready():
	if not bullet_scene or not explotion_scene:
		push_error('Some PackedScene is missing')
	
	$AnimatedSprite2D.play("default")
	position = _offset_vieport
	_screen_size = Global.screen_size + Vector2(0, 20.0) # a little higher than the initial
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = timer_shots # this is 2.0s
	timer.connect('timeout', Callable(self, '_on_special_action'))
	timer.start()



func _physics_process(_delta):
	_apply_movement()
	

func _apply_movement():
	if global_position.x > _on_viewport.x:
		velocity.x = -speed
	else:
		velocity.x = 0
		immunity = false
		
	if not immunity and not _is_dead:
		start_move_on_zigszag()
		_can_shoot = true
		
	elif _is_dead:
		_dead()
		
	move_and_slide()


func start_move_on_zigszag():
	if not immunity:
		_apply_zigzag()
	

func _apply_zigzag():
	# switch direction on up or down
	var dir = 1 if to_down else -1
	velocity.y = zigzag_speed * dir

	
func handler_zigzag_direction():
	to_down = not to_down


func _make_bullets():
	var _rand_y = randf_range(-4, 4) #y = -2
	var _g_position = global_position
	_g_position.x -= 8.0
	_g_position.y += _rand_y
	
	for _b in bullet_by_shots:
		var bullet = bullet_scene.instantiate()
		bullet.position = _g_position
		bullet.go_negative()
		add_sibling(bullet)


func _on_special_action():
	if _can_shoot:
		print(_can_shoot)
		_make_bullets()


func _dead():
	boss_collision.disabled = true
	velocity.y = zigzag_speed * 1
	
	if global_position.y > _screen_size.y:
		queue_free()

func make_boom():
	immunity = true
	_is_dead = true
	_can_shoot = false

	
	


