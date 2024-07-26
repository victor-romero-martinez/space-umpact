extends Node2D


@export_group('enemies_collections List')
@export var enemies_chunk: Array[PackedScene] = []


@onready var screen_size = Global.screen_size.x


# Called when the node enters the scene tree for the first time.
func _ready():
	_make_chunk()


func _make_chunk():
	if enemies_chunk.size() == 0:
		push_error('Enemy chunk scene is missig')
	else:
		for i in enemies_chunk.size():
			var chunk = enemies_chunk[i].instantiate()
			chunk.position.x = screen_size * (i + 1)
			add_child(chunk)
