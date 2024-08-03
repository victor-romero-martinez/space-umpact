extends Node2D

signal resume


func _ready():
	self.hide()


func _on_resume_pressed():
	resume.emit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
