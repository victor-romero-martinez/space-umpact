extends StaticBody2D

var limit = Global.screen_size
var speed: float = 100.0
var direction: int = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += (speed * direction)* delta
	if position.x > limit.x:
		queue_free()


#NOTE: using on enemy when shooting
func go_negative(spd: float = 20.0):
	direction = -1
	speed = spd


func _on_area_2d_area_entered(area):
	if area is EnemyHealthBox or area is PlayerHealthBox:
		area.take_damage()
	
	queue_free()
