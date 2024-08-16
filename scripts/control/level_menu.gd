@tool
extends Control


@export var levels: Array[PackedScene] = []

@onready var level_container = %LevelContainer


func _ready():
	if not levels.is_empty():
		var theme = load('res://control/theme/button_pink_theme.tres')
		for i in range(levels.size()):
			var button = Button.new()
			button.text = str(i + 1)
			button.theme = theme
			button.focus_mode = Control.FOCUS_NONE
			button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

			button.pressed.connect(func (): self.on_emit_level(i))

			level_container.add_child(button)
	else:
		push_error('Leveld PackedScene is missing')


func on_emit_level(index: int):
	get_tree().change_scene_to_packed(levels[index])


func _on_back_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")


func _on_restart_pressed():
	Global.update_save_data()
