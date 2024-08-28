extends ViewportDetector


func do_something():
	get_parent().on_viewport.emit()
