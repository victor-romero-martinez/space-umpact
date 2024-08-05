@icon("res://assets/icons/skull-and-crossbones.svg")
extends Enemy

signal on_viewport
signal hit(val: int)
signal activate_fight
signal set_health(val: int)
signal defeated

@export var health: int = 60
@export var speed: float = 8.0
@export var bullet_scene: PackedScene
## time elapsed between shots
@export var timer_shots: float = 2.0
@export var bullet_by_shots: int = 1
@export var explotion_scene: PackedScene
@export_category('Movement')
@export var fsm: EnemyStateMachine
@export var move_down: EnemyMoveDown
@export var move_up: EnemyMoveUp
@export var move_left: EnemyMoveLeft


var global
var _can_shoot: bool = false
var _is_dead: bool = false


func _ready():
	global = Global
	
	if fsm and move_down and move_up:
		move_left.end_move_left.connect(fsm.change_state.bind(move_up))
		move_down.end_move_down.connect(fsm.change_state.bind(move_up))
		move_up.end_move_up.connect(fsm.change_state.bind(move_down))
	
	$AnimatedSprite2D.play("default")
	
	var spetial_timer = Timer.new()
	add_child(spetial_timer)
	spetial_timer.one_shot = false
	spetial_timer.wait_time = timer_shots # this is 2.0s
	spetial_timer.connect('timeout', Callable(self, '_on_special_action'))
	spetial_timer.start()


func _physics_process(_delta):
	if global_position.x < global.screen_size.x\
	and global_position.y < global.screen_size.y:
		on_viewport.emit()

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
	global.defeated_boss = true
	$CollisionShape2D.disabled = true
	defeated.emit()
	
	if global_position.y > (global.screen_size.y + 20):
		global.queue_boss = true
		queue_free()


func _set_blinking():
	var _tween_timer: float = 0.25
	var tween: Tween = create_tween()
	
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.2, _tween_timer)
	tween.tween_property($AnimatedSprite2D, "modulate:a", 1.0, _tween_timer).from(_tween_timer)


func _make_boom():
	_is_dead = true
	_can_shoot = false
	_rand_explotion()
	%ExploitTrigger.start()
	

func apply_damge():
	health -= 1
	_set_blinking()
	hit.emit(1)
	if health == 0:
		_make_boom()


func _on_timer_timeout():
	_rand_explotion()
