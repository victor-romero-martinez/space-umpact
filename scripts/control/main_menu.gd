extends Control


@onready var global = Global


func _ready():
	if global.game_data.level > 1:
		%ContinueBtn.disabled = false
	else:
		%ContinueBtn.disabled = true
	
	# app settings
	$MarginContainer/Settings.visible = false
	# set color shema
	if global.game_data.theme:
		theme = load(global.game_data.theme[0])
		$ColorRect.color = global.game_data.theme[1]
		$MarginContainer/Settings/Theme/OptionButton.select(global.game_data.theme[3])
	

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_continue_pressed():
	if global.game_data.level:
		get_tree().change_scene_to_file("res://scenes/level_%d.tscn" %global.game_data.level)
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
	match index:
		0:
			self.theme = load(global.theme_schema[index][0])
			$ColorRect.color = Color(global.theme_schema[index][1])
			global.update_theme(global.theme_schema[index])
		1:
			self.theme = load(global.theme_schema[index][0])
			$ColorRect.color = Color(global.theme_schema[index][1])
			global.update_theme(global.theme_schema[index])
		2:
			self.theme = load(global.theme_schema[index][0])
			$ColorRect.color = Color(global.theme_schema[index][1])
			global.update_theme(global.theme_schema[index])
			
	
	
