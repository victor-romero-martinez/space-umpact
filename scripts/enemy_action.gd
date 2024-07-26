extends Area2D
class_name EnemyAction

func _ready():
	area_entered.connect(active)
	
	
func active(area):
	if area:
		print(area)
