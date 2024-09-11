@icon("res://assets/icons/skull-and-crossbones.svg")
extends Enemy


@export var health: int = 60
@export var speed: float = 14.0
## time elapsed between shots
@export var timer_attack: float = 4.0
@export var explotion_scene: PackedScene
@export var type_gun: PackedScene

@export_category('State')
@export var fsm: EnemyStateMachine
@export var move_down: EnemyMoveDown
@export var move_up: EnemyMoveUp
@export var move_left: EnemyMoveLeft
@export var attack: EnemyAttack
@export var dead_move: DeadBoss


@onready var global = Global

#var fight_position: Vector2
var _spetial_timer: Timer

func _ready():
	if fsm and move_down and move_up and move_left:
		move_left.end_move_left.connect(fsm.change_state.bind(move_up))
		move_down.end_move_down.connect(fsm.change_state.bind(move_up))
		move_up.end_move_up.connect(fsm.change_state.bind(move_down))
		connect('defeated', _make_boom)
		connect('activate_fight', _activate_figth)
	
	$AnimatedSprite2D.play("default")

	
# Start fight
func _activate_figth():
	#fight_position = global_position
	_spetial_timer = Timer.new()
	add_child(_spetial_timer)
	_spetial_timer.one_shot = false
	_spetial_timer.wait_time = timer_attack # this is 2.0s
	_spetial_timer.connect('timeout', Callable(self, '_on_special_action'))
	_spetial_timer.start()


# gun instantiate
func make_bullet():
	var rand_y = randf_range(-8, 8)
	var pos = position
	pos.x -= 16.0
	pos.y += rand_y
	
	var bullet = type_gun.instantiate()
	bullet.position = pos
	bullet.go_negative()

	add_sibling(bullet)


# attack
func _on_special_action():
	var last_state = fsm.current_state()
	
	fsm.change_state(attack)
	
	#attack.end_attack.connect(fsm.change_state.bind(last_state))
	# CAUTION: It must be reset to avoid state bug
	if attack.end_attack.is_connected(fsm.change_state):
		attack.end_attack.disconnect(fsm.change_state)
	
	fsm.change_state(last_state)

func _rand_explotion():
	var rand_position_x = randf_range(-12.0, 12.0)
	var rand_position_y = randf_range(-12.0, 12.0)
	var boom = explotion_scene.instantiate()
	boom.position = position + Vector2(rand_position_x, rand_position_y)
	
	add_sibling(boom)


func _make_boom():
	global.game_data.score += health
	global.defeated_boss = true
	_spetial_timer.stop()
	%ExploitTrigger.start()
	
	if dead_move:
		# ATTENTION: Disconnect move_down signal to avoid state inconsistency
		if move_down.end_move_down.is_connected(fsm.change_state):
			move_down.end_move_down.disconnect(fsm.change_state)
			
		fsm.change_state(dead_move)


func set_blinking(damage: int):
	hit.emit(damage)
	var _tween_timer: float = 0.25
	var tween: Tween = create_tween()
	
	tween.tween_property($AnimatedSprite2D, "modulate:a", 0.2, _tween_timer)
	tween.tween_property($AnimatedSprite2D, "modulate:a", 1.0, _tween_timer).from(_tween_timer)


func _on_timer_timeout():
	_rand_explotion()
