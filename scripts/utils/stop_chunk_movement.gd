extends ViewportDetector


@export var wait_time: float = 6.0


func do_something():
	var tmp = get_parent().speed
	get_parent().speed = 0 # NOTICE: this vector x
	await get_tree().create_timer(wait_time).timeout
	get_parent().speed = tmp # NOTICE: restore original value
	
