extends Node2D
class_name ChunkEnemy

@export var speed: float = 15.0

#WARNING: must be initialite before use on _precess
@onready var screen_size = -Global.screen_size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta
	
	if position.x < screen_size:
		queue_free()
