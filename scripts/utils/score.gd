extends Label



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Global.game_data.score).pad_zeros(7)
	material.set("shader_parameter/outline_color", Color(Global.game_data.theme[1]))
	material.set("shader_parameter/sprite_tint", Color(Global.game_data.theme[2]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(Global.game_data.score).pad_zeros(7)
