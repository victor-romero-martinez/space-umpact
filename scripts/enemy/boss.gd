@icon("res://assets/icons/skull-and-crossbones.svg")
extends Enemy


@export var health: int = 60
@export var speed: float = 16.0
@export var bullet_scene: PackedScene
## time elapsed between shots
@export var timer_shots: float = 4.0
@export var bullet_by_shots: int = 1
@export var explotion_scene: PackedScene
@export_category('Movement')
@export var fsm: EnemyStateMachine
@export var move_down: EnemyMoveDown
@export var move_up: EnemyMoveUp
@export var move_left: EnemyMoveLeft
@export var dead_move: DeadBoss


@onready var global = Global

var spetial_timer: Timer

func _ready():
	if fsm and move_down and move_up and move_left:
		move_left.end_move_left.connect(fsm.change_state.bind(move_up))
		move_down.end_move_down.connect(fsm.change_state.bind(move_up))
		move_up.end_move_up.connect(fsm.change_state.bind(move_down))
		connect('defeated', _dead)
		connect('activate_fight', _make_time)
	
	$AnimatedSprite2D.play("default")


func _physics_process(_delta):
	if global_position.x < global.screen_size.x\
	and global_position.y < global.screen_size.y:
		on_viewport.emit()
	

func _make_bullets():
	var rand_y = randf_range(-8, 8) #y = -2
	var g_position = global_position
	g_position.x -= 16.0
	g_position.y += rand_y
	
	for _b in bullet_by_shots:
		var bullet = bullet_scene.instantiate()
		bullet.position = g_position
		bullet.go_negative()
		add_sibling(bullet)


func _make_time():
	spetial_timer = Timer.new()
	add_child(spetial_timer)
	spetial_timer.one_shot = false
	spetial_timer.wait_time = timer_shots # this is 2.0s
	spetial_timer.connect('timeout', Callable(self, '_on_special_action'))
	spetial_timer.start()


# TODO: tal vez lo cambie a un estado
func _on_special_action():
	if global.defeated_boss:
		spetial_timer.stop()
	else:
		_make_bullets()
		


func _rand_explotion():
	var rand_position = randf_range(-10.0, 10.0)
	var boom = explotion_scene.instantiate()
	boom.position = position + Vector2(rand_position, rand_position)
	
	add_sibling(boom)


func _dead():
	global.defeated_boss = true
	$CollisionShape2D.disabled = true
	_rand_explotion()
	%ExploitTrigger.start()
	
	if dead_move:
		# ATTENTION: Disconnect move_down signal to avoid state inconsistency
		move_down.end_move_down.disconnect(fsm.change_state)
		fsm.change_state(dead_move)


func _set_blinking():
	var _tween_timer: float = 0.25
	var tween: Tween = create_tween()
	
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.2, _tween_timer)
	tween.tween_property($AnimatedSprite2D, "modulate:a", 1.0, _tween_timer).from(_tween_timer)


func apply_damge():
	health -= 1
	_set_blinking()
	hit.emit(1)
	
	if health == 0:
		defeated.emit()


func _on_timer_timeout():
	_rand_explotion()
