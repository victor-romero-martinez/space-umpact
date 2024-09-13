@icon("res://assets/icons/gear.svg")
extends Node2D

enum Movement { LEFT = -1, NONE = 0, RIGHT = 1 }
enum TBullet { rocket, laser_h, laser_v, random }

## Direction to movement
@export var direction:Movement = Movement.NONE
## Select type gun
@export var gun_type: TBullet = TBullet.random
## Velocity
@export var speed: float = 30.0
## Time
@export var wait_time_relad: float = 15.0
## Limit respawn position
@export var range_position: Vector2 = Vector2(10, 119)
## For respaown
@export var respawn: bool = false

var _reload_scene = preload('res://scenes/utilities/reload.tscn')
var _screen = Global.screen_size
var _aux_speed: float

func  _ready():
	if direction != Movement.NONE and respawn:
		respawner_fn()
	else:
		_on_make_scene()
	
	
func _process(delta):
	position.x += delta * (_aux_speed * direction)


func _on_make_scene():
	if !$Timer.is_stopped(): # if not stopped
		$Timer.stop()
		_aux_speed = speed
		
	var reload = _reload_scene.instantiate() as ReloadItem
	
	if gun_type != TBullet.random:
		reload.bullet_type = gun_type
	else:
		reload.random_type = true
	
	add_child.call_deferred(reload)
	

func _rand_position():
	var rand_y = randf_range(range_position.x, range_position.y)
	position = Vector2((_screen.x + 20), rand_y)

	
func respawner_fn():
	if respawn:
		_aux_speed = 0
		_rand_position()
		$Timer.wait_time = wait_time_relad
		$Timer.start()
