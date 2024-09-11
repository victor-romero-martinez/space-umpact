extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match OS.get_name():
		"Android": visible = true
		"iOS": visible = true
		_:
			visible = false
			set_process(false)
	
	
func _process(_delta: float) -> void:
	if Global.game_data.weapons.size() > 1:
		$B.visible = true
	else:
		$B.visible = false
		
	if Engine.time_scale == 0:
		visible = false
	else:
		visible = true
