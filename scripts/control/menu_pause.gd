extends Node2D

signal resume

@onready var global = Global

func _ready():
	self.hide()
	
	# set color shema
	if global.game_data.theme:
		$Control.theme = load(global.game_data.theme[0])
		$Control/ColorRect.color = global.game_data.theme[1]
	


func _on_resume_pressed():
	resume.emit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
