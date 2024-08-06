extends Control

@onready var global = Global


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" %Global.current_level)


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
