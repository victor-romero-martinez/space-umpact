@icon("res://assets/icons/gamepad.svg")
extends CharacterBody2D
class_name Player

''' This script is only for Player node.
	- Use actors.tscn to inherited scene located in res://entities/actors.tscn
	- Attach dragging in Player node
'''

signal hit

@export_group('Gun Settings')
#@export var bullet_scene: PackedScene
## how many bullets can shots
@export var bullet_by_shoot: int = 3
## how many time wait for the next shooting
@export var wait_seconds: float = .5
#@export var rcket_scene: PackedScene

@export_group('Settings')
@export var speed = 80.0
@export var respawn: Marker2D
@export var exit_screen: Marker2D
@export var explotion_scene: PackedScene

@onready var global = Global

enum TState { IMMUNITY, MOVE, FREEZE }

const GUNS := {
	'bullet': preload('res://scenes/utilities/bullet.tscn'),
	'rocket': preload('res://scenes/utilities/rocket.tscn'),
	'laser_h': null,
	'laser_v': null
}

var _can_shoot: bool = true
var state: TState = TState.IMMUNITY


func _ready():
	_animation_spawn()
	_start_combat()


func _physics_process(delta):
	if state == TState.MOVE or state == TState.IMMUNITY:
		_move(delta)
		move_and_slide()
	
	if is_on_wall() or is_on_floor(): make_boom()
	if Input.is_action_just_pressed("ui_accept"): _fire()
	if global.queue_boss: _finish_combat()
	

func _move(delta):
	var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = direction.normalized() * speed

	if state == TState.MOVE or state == TState.IMMUNITY:
		# limits movement on the screen
		#WARNING: hace un pequeño movimineto
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, (Global.screen_size - Vector2(21.0, 15.0)))

# enter from outside
func _start_combat():
	var t = create_tween()
	t.tween_property(self, 'global_position', respawn.position, .45)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_OUT)
	t.tween_callback(func (): state = TState.MOVE)
	
	
func _finish_combat():
	state = TState.FREEZE
	$CollisionShape2D.disabled = true
	velocity.x = speed * 2
	if global_position.x > global.screen_size.x: global.hidden_player = true
	move_and_slide()
	
	
# apply damage and reset position when not immunity
func make_boom():
	#if not IMMUNITY OR FREEZE:
	if state == TState.MOVE:
		_apply_explotion()
		_animation_spawn()
		
		hit.emit()
		global_position = respawn.position


# apply animation
func _animation_spawn():
	state = TState.IMMUNITY
	$AnimatedSprite2D.play('respawn')
	await get_tree().create_timer(2.0).timeout
	state = TState.MOVE
	$AnimatedSprite2D.play('default')


#TODO: destroy when colliction by buildings
func _fire():
	if _can_shoot:
		for _b in bullet_by_shoot:
			#var bullet = bullet_scene.instantiate()
			var bullet = GUNS.bullet.instantiate()
			bullet.position = global_position + Vector2(28, 8)
			add_sibling(bullet)
			
			await get_tree().create_timer(0.06).timeout #WARNING: no estoy seguro de esto
			
		_shoot_handle()


func add_arsenal(arg: String):
	if not global.player_arsenal.has(arg):
		global.player_arsenal.append(arg)
		print(global.player_arsenal)


# add explotion as sibling 
func _apply_explotion():
	var boom = explotion_scene.instantiate()
	boom.position = global_position + Vector2(4, 6)
	add_sibling(boom)


func _shoot_handle():
	_can_shoot = false
	await get_tree().create_timer(wait_seconds).timeout
	_can_shoot = true

