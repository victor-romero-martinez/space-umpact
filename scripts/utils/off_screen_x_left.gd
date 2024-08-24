extends Area2D
class_name XLeft


func _on_area_exited(area):
	if area is Destroyer:
		area.do_something()
