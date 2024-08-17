extends Control

@onready var global = Global


func _ready():
	# set color shema
	if global.game_data.theme:
		theme = load(global.game_data.theme[0])
		$ColorRect.color = global.game_data.theme[1]
	

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" %Global.game_data.level)


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
