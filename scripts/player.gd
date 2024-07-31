@icon("res://assets/icons/gamepad.svg")
extends CharacterBody2D

''' This script is only for Player node.
	- Use actors.tscn to inherited scene located in res://entities/actors.tscn
	- Attach dragging in Player node
'''

@export_group('Bullet Settings')
@export var bullet_scene: PackedScene
## how many bullets can shots
@export var bullet_by_shoot: int = 3
## how many time wait for the next shooting
@export var wait_seconds: float = .5

@export_group('Settings')
@export var speed = 40.0
@export var respawn: Marker2D
@export var explotion_scene: PackedScene

@onready var hud_health = $"../../Hud/HudHealth" as HudHealth

var global
var _can_shoot: bool = true
var _immunity = true
var _can_move = false


func _ready():
	if not bullet_scene\
	or not explotion_scene\
	or not respawn:
		push_error('Some PackedScene is missing')
		return
	
	global = Global
	_animation_spawn()
	_start_combat()

func _physics_process(delta):
	if _can_move:
		_move(delta)
		move_and_slide()
	
	#INFO: received damage and restart initioal position
	if is_on_wall() or is_on_floor():
		make_boom()

	if Input.is_action_just_pressed("ui_accept"):
		_fire()


func _move(delta):
	var direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	velocity = direction.normalized() * speed

	if _can_move:
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
	t.tween_callback(func (): _can_move = true)
	
	
# apply damage and reset position when not immunity
func make_boom():
	if not _immunity:
		_apply_explotion()
		_animation_spawn()
		
		global_position = respawn.position
		
		global.take_damage() #NOTE: base 1
		hud_health.remove_heart() #NOTE: base index 0


# apply animation
func _animation_spawn():
	_immunity = true
	$AnimatedSprite2D.play('respawn')
	await get_tree().create_timer(2.0).timeout
	_immunity = false
	$AnimatedSprite2D.play('default')


#TODO: destroy when colliction by buildings
func _fire():
	if _can_shoot:
		for _b in bullet_by_shoot:
			var bullet = bullet_scene.instantiate()
			bullet.position = global_position + Vector2(14, 4)
			add_sibling(bullet)
			
			await get_tree().create_timer(0.03).timeout #WARNING: no estoy seguro de esto
			
		_shoot_handle()


# add explotion as sibling 
func _apply_explotion():
	var boom = explotion_scene.instantiate()
	boom.position = global_position + Vector2(4, 6)
	add_sibling(boom)


func _shoot_handle():
	_can_shoot = false
	await get_tree().create_timer(wait_seconds).timeout
	_can_shoot = true

