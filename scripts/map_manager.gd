@icon("res://assets/icons/gear.svg")
extends Node2D

@onready var screen_size = Global.screen_size.x

var total_size:float
var counter: int = 0

func _ready():
	counter = get_child_count()
	
	for i in counter:
		total_size = screen_size * i
		var c = get_child(i)
		c.position.x = total_size


#NOTE: no se si esta sea lo mas optimo
func _on_tile_map_screen_out(body):
	body.position.x = total_size

func _on_tile_map_1_screen_out(body):
	body.position.x = total_size


func _on_tile_map_2_screen_out(body):
	body.position.x = total_size
