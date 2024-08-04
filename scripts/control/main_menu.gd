extends Control


@onready var global = Global


func _ready():
	if global.current_level > 1:
		%ContinueBtn.disabled = false
	else:
		%ContinueBtn.disabled = true


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" %global.current_level)


func _on_level_pressed():
	get_tree().change_scene_to_file("res://control/level_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
