extends Area2D
class_name XLeft


func _on_area_exited(area):
	if area is Destroyer or area is ViewportDetector:
		area.do_something()
