@icon("res://assets/icons/tools.svg")
extends StaticBody2D
class_name ReloadItem


enum TBullet { rocket, laser_h, laser_v }

@export var bullet_type: TBullet
@onready var global = Global

func _ready():
	%AnimatedSprite.play(TBullet.keys()[bullet_type])
	

func _on_area_2d_area_entered(area):
	if area is PlayerCollectorItem:
		if global.player_arsenal.has(TBullet.keys()[bullet_type]): return
		
		area.received_item(TBullet.keys()[bullet_type])
		queue_free()
			

