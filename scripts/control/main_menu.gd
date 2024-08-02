extends Control



func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_continue_pressed():
	pass # Replace with function body.


func _on_level_pressed():
	get_tree().change_scene_to_file("res://control/level_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
