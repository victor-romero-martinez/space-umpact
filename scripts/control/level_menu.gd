@tool
extends Control


@export var levels: Array[PackedScene] = []

@onready var level_container = %LevelContainer

@onready var global = Global


func _ready():
	# set color shema
	if global.game_data.theme:
		theme = load(global.game_data.theme[0])
		$ColorRect.color = global.game_data.theme[1]
	
	# set levels
	if not levels.is_empty():
		for i in range(levels.size()):
			var button = Button.new()
			button.text = str(i + 1)
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
