@icon("res://assets/icons/gear.svg")
extends Node2D

enum Movement { LEFT = -1, NONE = 0, RIGHT = 1 }
enum TBullet { rocket, laser_h, laser_v, random }

@export var direction:Movement = Movement.NONE
@export var speed: float = 30.0
@export var gun_type: TBullet = TBullet.random
@export var wait_time: float = 3.0
@export var respown: bool = false

var _reload_scene = preload('res://scenes/utilities/reload.tscn')

func  _ready():
	_make_scene()
	
	
func _process(delta):
	position.x += delta * (speed * direction)

func _make_scene():
	var reload = _reload_scene.instantiate() as ReloadItem
	
	if gun_type != TBullet.random:
		reload.bullet_type = gun_type
	else:
		reload.random_type = true
	
	if respown:
		$Timer.stop()
		reload.tree_exited.connect(_respown)
	
	add_child(reload)
	
	
func _respown():
	$Timer.start()
	$Timer.wait_time = wait_time
