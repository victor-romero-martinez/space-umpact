extends Node2D
class_name XRight


func _on_area_exited(area):
	if area is Destroyer or area is ViewportDetector:
		area.do_something()
