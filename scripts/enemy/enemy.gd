@icon("res://assets/icons/skull-and-crossbones.svg")
extends Enemy

''' This script is only for Enemy node.
	- Use actors.tscn to inherited scene located in res://entities/actors.tscn
	- Attach dragging in your Enemy node.
'''


## initial health
@export var health: int = 2
## use on state machine
@export var speed: float = 0.0
## active for can_shoot mode
@export var can_shoot: bool = false
@export var timer_range: Vector2 = Vector2(2.5, 5.0)
@export var explotion_scene: PackedScene
@export var bullet_scene: PackedScene

@export_category('State')
## State machine controller
@export var fsm: EnemyStateMachine
@export var move_down: EnemyMoveDown
@export var move_up: EnemyMoveUp
## Attack State
@export var attack: EnemyAttack


#WARNING: must be initialite before use on _make_bullets
@onready var global = Global

var _is_already_timer: bool = false


func _ready():
	if fsm and move_down and move_up:
		move_down.end_move_down.connect(fsm.change_state.bind(move_up))
		move_up.end_move_up.connect(fsm.change_state.bind(move_down))
	
	connect('defeated', _make_boom)
	$AnimatedSprite2D.play("default")


func set_blinking(_damage: int):
	var _tween_timer: float = 0.25
	var tween: Tween = create_tween()
	
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.2, _tween_timer)
	tween.tween_property($AnimatedSprite2D, "modulate:a", 1.0, _tween_timer).from(_tween_timer)


func _make_boom():
	if not explotion_scene:
		push_error('Explotion PackScene is missing')
	else:
		var boom = explotion_scene.instantiate()
		boom.position = position
		add_sibling(boom)
		
		queue_free()


func _make_bullet():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.position = position + Vector2(-16.0, 0)
		bullet.go_negative()
	
		add_sibling(bullet)
	else:
		printerr('Bullet Scene is missing')


# setting the timer
func start_timer():
	if not _is_already_timer:
		var rand_time = randf_range(timer_range.x, timer_range.y)
		var _timer: Timer
		_timer = Timer.new()
		_timer.wait_time = rand_time
		_timer.autostart = true
		_timer.timeout.connect(_on_attack)
		
		add_child(_timer)
		_is_already_timer = true
	
	
# attack
func _on_attack():
	var last_state = fsm.current_state()
	
	fsm.change_state(attack)
	
	#attack.end_attack.connect(fsm.change_state.bind(last_state))
	# CAUTION: It must be reset to avoid state bug
	if attack.end_attack.is_connected(fsm.change_state):
		attack.end_attack.disconnect(fsm.change_state)
		
	fsm.change_state(last_state)
	_make_bullet()
