extends Area2D
class_name EnemyHitBox



func _ready():
	area_entered.connect(_hit)
	
	
func _hit(area):
	if area is PlayerHealthBox:
		area.take_damage()
