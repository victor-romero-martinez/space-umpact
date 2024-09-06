extends Control

const 	CREDITS_PATH = "res://credits.json"


@onready var credit_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/CreditContainer


func _ready():
	# set color shema
	if Global.game_data.theme:
		theme = load(Global.game_data.theme[0])
		$ColorRect.color = Global.game_data.theme[1]
	
	_open_credit_file()


func _make_label(txt: String):
	var label = Label.new()
	label.text = txt
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	credit_container.add_child(label)


func _make_separator() -> HSeparator:
	var separator = HSeparator.new()
	separator.modulate = Color('#ffffff00')
	separator.custom_minimum_size = Vector2(0, 5.0)
	return separator


func _open_credit_file():
	var file = FileAccess.open(CREDITS_PATH, FileAccess.READ)
	var txt = file.get_as_text()
	var json = JSON.new()
	var err = json.parse(txt)
	
	if err == OK:
		var data = json.data
		
		credit_container.add_child(_make_separator())
		_make_label('Music')
		credit_container.add_child(_make_separator())
		
		for n in data.music:
			_make_label(n.author_name)
			
		credit_container.add_child(_make_separator())
		_make_label('Sfx')
		credit_container.add_child(_make_separator())
		
		for n in data.sfx:
			_make_label(n.author_name)
			
	else:
		push_error('Unexpected data')
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://control/main_menu.tscn")
