extends Area2D
class_name PlayerHitBox


func _ready():
	area_entered.connect(_hit)
	
	
func _hit(area):
	if area is EnemyHealthBox:
		area.take_damage()
