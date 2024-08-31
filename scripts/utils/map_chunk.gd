extends Node2D
class_name MapChunk

signal off_screen(body)

@export var speed: float = 8.0
@onready var screen_size = -Global.screen_size.x #WARNING: must be negative

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x = position.x + delta * -speed
	
	if position.x < screen_size: # screen_size is negative value (e.g. -176)
		off_screen.emit(self)
