@icon("res://assets/icons/crossed-swords.svg")
extends CharacterBody2D
## Rocket gun
class_name Rocket


enum Direction { LEFT = -1, RIGHT = 1 }

## Rocket velocity
@export var speed = 30.0
## Orientation rocket
@export var directon: Direction = Direction.RIGHT
## Explotion effects scene
@export var explotion: PackedScene

@onready var global = Global

var _collitions: Array[CollisionObject2D] = []

var _handler_zigzag_y: bool = true

func _ready():
	if directon == Direction.LEFT:
		$Sprite2D.flip_h = true
		$Sensor.rotation_degrees = 180
		$HitBox.rotation_degrees = 180


func _physics_process(_delta):
	velocity.x = directon * speed
		
	
	if _collitions.is_empty():
		if _handler_zigzag_y:
			velocity.y = speed * 1
		else:
			velocity.y = speed * -1
	else:
		_scan()
	
	move_and_slide()


# NOTE: puede generar bug si solo se usa como referencua la posicion del array
func _scan():
	if _collitions[0].global_position.y > global_position.y:
		velocity.y = speed * 1
	else:
		velocity.y = speed * -1
		

func _make_boom():
	if explotion:
		var boom = explotion.instantiate()
		boom.position = global_position
		add_sibling(boom)


# add
func _on_sensor_body_entered(body):
	_collitions.append(body)


# remove
func _on_sensor_body_exited(body):
	_collitions.erase(body)
	

func _on_hit_box_area_entered(area):
	if area is EnemyHealthBox or area is PlayerHealthBox:
		area.take_damage(6)
	
	_make_boom()
	queue_free()


func _on_timer_timeout():
	_handler_zigzag_y = not _handler_zigzag_y
