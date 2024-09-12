extends Label



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Global.game_data.score).pad_zeros(7)
	add_theme_color_override("font_outline_color", Color(Global.game_data.theme[1]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(Global.game_data.score).pad_zeros(7)
