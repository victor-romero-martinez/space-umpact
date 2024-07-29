@icon("res://assets/icons/tools.svg")
extends AnimatedSprite2D

func _ready():
	self.play('default')

func _on_animation_finished():
	queue_free()
