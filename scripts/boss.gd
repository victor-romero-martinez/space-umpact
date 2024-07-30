@icon("res://assets/icons/skull-and-crossbones.svg")
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
## initial position
@export var initial_position: Marker2D
## position on game
@export var final_position: Marker2D


var _screen_size: Vector2
var _can_shoot: bool = false
var _is_dead: bool = false


func _ready():
	if not bullet_scene or not explotion_scene:
		push_error('Some PackedScene is missing')
		
	if initial_position and final_position:
		_enter_the_stage()
	else:
		printerr('Initial or final position is undefined')
	
	$AnimatedSprite2D.play("default")
	_screen_size = Global.screen_size + Vector2(0, 20.0) # a little higher than the initial
	
	var spetial_timer = Timer.new()
	add_child(spetial_timer)
	spetial_timer.one_shot = false
	spetial_timer.wait_time = timer_shots # this is 2.0s
	spetial_timer.connect('timeout', Callable(self, '_on_special_action'))
	spetial_timer.start()


func _physics_process(_delta):
	_apply_movement()
	

func _enter_the_stage():
	global_position = initial_position.position
	var t = create_tween()
	t.tween_property(self, 'global_position', final_position.position, 3.5)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	t.tween_callback(func (): immunity = false)


func _apply_movement():
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
		_make_bullets()


func _rand_explotion():
	var _rand_position = randf_range(-10.0, 10.0)
	var boom = explotion_scene.instantiate()
	boom.position = position + Vector2(_rand_position, _rand_position)
	
	add_sibling(boom)


func _dead():
	$CollisionShape2D.disabled = true
	velocity.y = zigzag_speed * 1
	
	if global_position.y > _screen_size.y:
		queue_free()


func _set_blinking():
	var _tween_timer: float = 0.25
	var tween: Tween = create_tween()
	
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.2, _tween_timer)
	tween.tween_property($AnimatedSprite2D, "modulate:a", 1.0, _tween_timer).from(_tween_timer)


func _make_boom():
	immunity = true
	_is_dead = true
	_can_shoot = false
	_rand_explotion()
	%ExploitTrigger.start()
	

func apply_damge():
	if not immunity:
		health -= 1
		_set_blinking()
		if health == 0:
			_make_boom()


func _on_timer_timeout():
	_rand_explotion()
