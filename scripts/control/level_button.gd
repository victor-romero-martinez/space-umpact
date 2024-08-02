extends Button
class_name LevelButton


signal set_level(level_index: int)


func _ready():
	connect('pressed', Callable(self, '_on_pressed'))
	
	
func _on_pressed():
	#var who_i_am = get_parent().get_children()
	#self.id = 1
	print(self)
