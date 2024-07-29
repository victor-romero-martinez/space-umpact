extends Node2D


@export var speed: float = 15.0

var screen_size: float


func _ready():
	screen_size = ProjectSettings.get_setting('display/window/size/viewport_width')
	print(screen_size)


func _process(delta):
	if position.x > screen_size:
		position.x -= speed * delta
	

