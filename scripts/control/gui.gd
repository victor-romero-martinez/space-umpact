extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match OS.get_name():
		"Android": visible = true
		"iOS": visible = true
		_: visible = false
