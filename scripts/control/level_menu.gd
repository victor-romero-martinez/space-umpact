@tool
extends Control


@export var levels: Array[PackedScene] = []

@onready var level_container = %LevelContainer


func _ready():
	if not levels.is_empty():
		for i in range(levels.size()):
			var button = Button.new()
			button.text = str(i + 1)
			button.add_theme_font_size_override("font_size", 8)
			button.add_theme_color_override("font_color", "#f63090")
			button.focus_mode = FOCUS_NONE

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
