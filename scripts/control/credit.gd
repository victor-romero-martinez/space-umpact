extends Control



func _ready():
	# set color shema
	if Global.game_data.theme:
		theme = load(Global.game_data.theme[0])
		$ColorRect.color = Global.game_data.theme[1]
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")
