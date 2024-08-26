@icon("res://assets/icons/skull-and-crossbones.svg")
extends Enemy

''' This script is only for Enemy node.
	- Use actors.tscn to inherited scene located in res://entities/actors.tscn
	- Attach dragging in your Enemy node.
'''


## initial health
@export var health: int = 1
## use on state machine
@export var speed: float = 0.0
## active for can_shoot mode
@export var can_shoot: bool = false
@export var explotion_scene: PackedScene
@export_category('State')
## State machine controller
@export var fsm: EnemyStateMachine
@export var move_down: EnemyMoveDown
@export var move_up: EnemyMoveUp
## Attack State
@export var attack: EnemyAttack


#WARNING: must be initialite before use on _make_bullets
@onready var global = Global


var _timer_off: bool = true

func _ready():
	if can_shoot and attack:
		connect('on_viewport', _start_timer)
	
	if fsm and move_down and move_up:
		move_down.end_move_down.connect(fsm.change_state.bind(move_up))
		move_up.end_move_up.connect(fsm.change_state.bind(move_down))
	
	connect('defeated', _make_boom)
	$AnimatedSprite2D.play("default")


func _physics_process(_delta):
	if global_position.x < global.screen_size.x:
		on_viewport.emit()
		

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


# setting the timer
func _make_timer():
	var rand_time = randf_range(2.5, 5.0)
	var timer: Timer
	
	timer = Timer.new()
	timer.wait_time = rand_time
	timer.autostart = true
	timer.timeout.connect(_on_attack)
	
	add_child(timer)
	

# launch the timer
func _start_timer():
	if _timer_off:
		_make_timer()
		
	_timer_off = false


# attack
func _on_attack():
	var last_state = fsm.current_state()
	
	fsm.change_state(attack)
	
	attack.end_attack.connect(fsm.change_state.bind(last_state))
	# CAUTION: It must be reset to avoid state bug
	attack.end_attack.disconnect(fsm.change_state)
