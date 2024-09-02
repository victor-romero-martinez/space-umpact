@icon("res://assets/icons/gamepad.svg")
extends CharacterBody2D
## This script is only for Player node.[br]
## 1. Use actors.tscn to inherited scene located in res://entities/actors.tscn.[br]
## 2. Attach dragging in Player node.
class_name Player


signal hit
signal current_weapon(idx: int)
signal add_weapon(idx: int)
signal remove_weapon(val: int)

#region Gun settings
@export_group('Gun Settings')
## How many bullets can shots
@export var bullet_by_shoot: int = 3
## How many time wait for the next shooting
@export var wait_seconds: float = .5
#endregion


#region Settings
@export_group('Settings')
## Player velocity
@export var speed = 50.0
## Player initial position
@export var initial_position: Marker2D
## Player respawn position
@export var respawn: Marker2D
## Explotion effects scene
@export var explotion_scene: PackedScene
#endregion

@onready var global = Global

enum TState { IMMUNITY, MOVE, FREEZE }
enum TBullet { bullet, rocket, laser_h, laser_v }

#region List of guns
var GUNS = {
	'bullet': load('res://scenes/utilities/bullet.tscn'),
	'rocket': load('res://scenes/utilities/rocket.tscn'),
	'laser_h': load('res://scenes/utilities/laser_h.tscn'),
	'laser_v': load("res://scenes/utilities/laser_v.tscn")
}
#endregion

## Limit to prevent the player from leaving the screen
var offset: float = 10.0
var _can_shoot: bool = true
var _weapon_idx: int = 0
## States of state machine
var state: TState = TState.IMMUNITY


func _ready():
	global_position = initial_position.position
	current_weapon.emit(TBullet.bullet)
	_start_combat()
	

func _physics_process(delta):
	if state == TState.MOVE or state == TState.IMMUNITY:
		_move(delta)
	
	move_and_slide()
	
	if is_on_wall() or is_on_floor(): make_boom()
	if Input.is_action_just_pressed('change_weapon'): _next_weapon()
	if Input.is_action_just_pressed("ui_accept"): _fire()
	if global.queue_boss: _finish_combat()
	

func _move(delta):
	var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = direction.normalized() * speed

	# limits movement on the screen
	#WARNING: hace un pequeño movimineto
	position += velocity * delta
	position = position.clamp(
		Vector2(offset, offset), (Global.screen_size - Vector2(offset, offset))
	)


# apply animation
func _animation_spawn():
	state = TState.IMMUNITY
	$AnimatedSprite2D.play('respawn')
	$ShieldSfx.play()
	await get_tree().create_timer(2.0).timeout
	state = TState.MOVE
	$AnimatedSprite2D.play('default')
	$ShieldSfx.stop()


# enter from outside
func _start_combat():
	var t = create_tween()
	t.tween_property(self, 'global_position', respawn.position, .45)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_OUT)
	_animation_spawn()
	t.tween_callback(func (): state = TState.IMMUNITY)
	
	
# change level when finish fight 
func _finish_combat():
	state = TState.FREEZE
	%PlayerCollision.disabled = true
	velocity.x = speed * 2
	if global_position.x > global.screen_size.x: global.hidden_player = true
	
	
## Applies damage, explosion effect and resets position when not immunity
func make_boom():
	#if not IMMUNITY OR FREEZE:
	if state == TState.MOVE:
		state = TState.FREEZE # NOTICE: change state before, after change position
		_apply_explotion()
		global_position = initial_position.position
		
		hit.emit()
		
		await get_tree().create_timer(1.0).timeout
		_start_combat()


# Select ammunition type and shoot
func _fire():
	if _can_shoot:
		for _b in bullet_by_shoot:
			var bullet = GUNS[global.game_data.weapons[_weapon_idx]].instantiate()
			bullet.position = global_position + Vector2(20.0, 0)
			add_sibling(bullet)
			
			
			if _weapon_idx != 0:
				global.game_data.weapons.remove_at(_weapon_idx)
				
				var temp = _weapon_idx
				_weapon_idx = 0
				current_weapon.emit(_weapon_idx)
				remove_weapon.emit(temp)
				break
			await get_tree().create_timer(0.06).timeout #WARNING: no estoy seguro de esto
			
		_shoot_handle()


## Add gun type on [u]global.game_data.weapons[/u]
func add_arsenal(arg: String):
	if not global.game_data.weapons.has(arg):
		global.game_data.weapons.append(arg)
		add_weapon.emit(TBullet.get(arg))
		

# Set nex weapon
func _next_weapon():
	# [].size() -> base 1
	if (global.game_data.weapons.size() - 1) > _weapon_idx:
		_weapon_idx += 1
		current_weapon.emit(_weapon_idx)
	else:
		_weapon_idx = 0
		current_weapon.emit(_weapon_idx)
	

# add explotion as sibling 
func _apply_explotion():
	var boom = explotion_scene.instantiate()
	boom.position = global_position
	add_sibling(boom)


# wating shoot
func _shoot_handle():
	_can_shoot = false
	await get_tree().create_timer(wait_seconds).timeout
	_can_shoot = true
