extends Area2D
class_name PlayerCollectorItem


func received_item(item: String):
	get_parent().add_arsenal(item)

