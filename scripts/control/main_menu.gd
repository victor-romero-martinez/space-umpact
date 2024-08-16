extends Control


@onready var global = Global


func _ready():
	if global.current_level > 1:
		%ContinueBtn.disabled = false
	else:
		%ContinueBtn.disabled = true
	
	$MarginContainer/Settings.visible = false


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_continue_pressed():
	if global.current_level:
		get_tree().change_scene_to_file("res://scenes/level_%d.tscn" %global.current_level)
	else:
		%ContinueBtn.disabled = true
		


func _on_level_pressed():
	get_tree().change_scene_to_file("res://control/level_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	$MarginContainer/Main.visible = false
	$MarginContainer/Settings.visible = true


func _on_button_pressed():
	$MarginContainer/Main.visible = true
	$MarginContainer/Settings.visible = false
	

func _on_option_button_item_selected(index):

	var theme_schema := {
		0: [load('res://control/theme/button_pink_theme.tres'), '#201d24'],
		1: [load('res://control/theme/button_classic_theme.tres'), '#74a583']
	}
	
	match index:
		0:
			self.theme = theme_schema[index][0]
			$ColorRect.color = Color(theme_schema[index][1])
		1:
			self.theme = theme_schema[index][0]
			$ColorRect.color = Color(theme_schema[index][1])
	
	
