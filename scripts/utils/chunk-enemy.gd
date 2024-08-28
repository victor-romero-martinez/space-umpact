extends Node2D
class_name ChunkEnemy

signal next_chunk

var speed: float = 0.0


func _ready():
	if get_parent() is EnemyManager:
		speed = get_parent().speed


func _process(delta):
	position.x -= speed * delta
