extends Node2D
class_name ChunkEnemy

@export var speed: float = 30.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta
