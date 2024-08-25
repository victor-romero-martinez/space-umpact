@icon("res://assets/icons/gear.svg")
extends Node2D
## [color=GREEN]Background control[/color]
class_name BackgroundManager


@export var list_map: Array[MapChunk] = []

@onready var screen_size = Global.screen_size.x

var total_size:float
var counter: int = 0

func _ready():
	if not list_map.is_empty():
		for child in list_map:
			total_size = screen_size * counter
			child.position.x = total_size
			child.off_screen.connect(_on_exit_screen)
			counter += 1
	else:
		push_error('List map is empty')
#
#
#NOTE: no se si esta sea lo mas optimo
func _on_exit_screen(body):
	body.position.x = total_size
#
