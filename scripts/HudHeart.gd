extends Node2D
class_name HudHealth

@export var heart_compnent: PackedScene
@export var initial_position: Vector2 = Vector2(8.0, 0)

var global_settings = Global


# Called when the node enters the scene tree for the first time.
func _ready():
	if heart_compnent:
		for health in global_settings.player_health:
			var heart = heart_compnent.instantiate()
			heart.position = initial_position * health #NOTE: (x * i, y * i)
			add_child(heart)
	else:
		push_error('PackedScene is missing')
	

func remove_heart():
	if get_child_count() > 0:
		get_child(global_settings.player_health).queue_free()
