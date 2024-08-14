extends Node2D
class_name XRight


func _on_area_exited(area):
	if area is Destroyer:
		area.remove_me()
