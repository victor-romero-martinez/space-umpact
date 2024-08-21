extends Control


@export var levels: Array[PackedScene] = []


@onready var global = Global

## Min value for audio bus control
const MIN_VOL = -20

func _ready():
	if global.game_data.level > 1:
		%ContinueBtn.disabled = false
	else:
		%ContinueBtn.disabled = true
	
	# app settings
	$MarginContainer/Main.visible = true
	$MarginContainer/Settings.visible = false
	$MarginContainer/Level.visible = false
	$MarginContainer/Settings/Music/MusicSlide.value = global.game_data.music
	$MarginContainer/Settings/VFX/VFXSlide.value = global.game_data.sfx
	
	_set_theme()
	_level_creen()
	
	
## set color shema
func _set_theme():
	if global.game_data.theme:
		theme = load(global.game_data.theme[0])
		$ColorRect.color = global.game_data.theme[1]
		$MarginContainer/Settings/Theme/OptionButton.select(global.game_data.theme[3])
	
	
## set levels
func _level_creen():
	if not levels.is_empty():
		for i in range(levels.size()):
			var button = Button.new()
			button.text = str(i + 1)
			button.focus_mode = Control.FOCUS_NONE
			button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

			button.pressed.connect(func (): self.on_emit_level(i))

			$MarginContainer/Level/LevelContainer.add_child(button)
	else:
		push_error('Leveld PackedScene is missing')
	
	
func _on_new_game_pressed():
	$Beep1.play()
	$Beep1.finished.connect(func (): get_tree().change_scene_to_file("res://scenes/level_1.tscn"))
	

func _on_continue_pressed():
	if global.game_data.level:
		$Beep1.play()
		$Beep1.finished.connect(func (): get_tree().change_scene_to_file("res://scenes/level_%d.tscn" %global.game_data.level))
	else:
		%ContinueBtn.disabled = true
		

func _on_level_pressed():
		$Beep1.play()
		$MarginContainer/Main.visible = false
		$MarginContainer/Level.visible = true
	
	
func on_emit_level(index: int):
	$Beep2.play()
	$Beep2.finished.connect(func (): get_tree().change_scene_to_packed(levels[index]))
	
	
func _on_quit_pressed():
	$Beep2.play()
	$Beep2.finished.connect(func (): get_tree().quit())
	

func _on_settings_pressed():
	$MarginContainer/Main.visible = false
	$MarginContainer/Settings.visible = true
	$Beep1.play()


func _on_button_pressed():
	$MarginContainer/Main.visible = true
	$MarginContainer/Settings.visible = false
	$Beep2.play()
	

func _on_option_button_item_selected(index):
	match index:
		0:
			self.theme = load(global.theme_schema[index][0])
			$ColorRect.color = Color(global.theme_schema[index][1])
			global.game_data.theme = global.theme_schema[index]
			global.update_data()
		1:
			self.theme = load(global.theme_schema[index][0])
			$ColorRect.color = Color(global.theme_schema[index][1])
			global.game_data.theme = global.theme_schema[index]
			global.update_data()
		2:
			self.theme = load(global.theme_schema[index][0])
			$ColorRect.color = Color(global.theme_schema[index][1])
			global.game_data.theme = global.theme_schema[index]
			global.update_data()
		
	$Beep1.play()
	

func _game_volumen(name_db: String, value: float):
	var bus_idx = AudioServer.get_bus_index(name_db)
	
	if value > MIN_VOL:
		AudioServer.set_bus_volume_db(bus_idx, value)
	else:
		AudioServer.set_bus_volume_db(bus_idx, -80)
	
	# NOTE: saving data
	global.game_data[name_db] = value


func _on_vfx(value):
	_game_volumen('sfx', value)


func _on_music(value):
	_game_volumen('music', value)
		
	
func _on_music_slide_drag_ended(value_changed):
	if value_changed:
		global.update_data()
		$Beep1.play()


func _on_vfx_slide_drag_ended(value_changed):
	if value_changed:
		global.update_data()
		$Beep1.play()
	

func _on_back_pressed():
	$Beep2.play()
	$MarginContainer/Level.visible = false
	$MarginContainer/Main.visible = true


func _on_restart_pressed():
	$Beep1.play()
	global.game_data.level = 1
	global.update_data()
	%ContinueBtn.disabled = true
	
