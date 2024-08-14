@icon("res://assets/icons/tools.svg")
extends StaticBody2D
class_name ReloadItem


enum TBullet { rocket, laser_h, laser_v }

@export var bullet_type: TBullet
@export var random_type: bool = false

@onready var global = Global

var _gun_name: String

func _ready():
	if random_type:
		var random_idx = randi_range(0, (TBullet.size() - 1))
		_gun_name = TBullet.find_key(random_idx)
	else:
		_gun_name = TBullet.keys()[bullet_type]
		
	%AnimatedSprite.play(_gun_name)
	

func _on_area_2d_area_entered(area):
	if area is PlayerCollectorItem:
		if global.player_arsenal.has(_gun_name): return
		
		area.received_item(_gun_name)
		queue_free()
			

