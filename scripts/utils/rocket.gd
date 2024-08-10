extends CharacterBody2D
class_name Rorcket


enum Direction { LEFT = -1, RIGHT = 1 }

@export var speed = 30.0
@export var directon: Direction = Direction.RIGHT
@export var explotion: PackedScene

@onready var global = Global

var collitions: Array[CollisionObject2D] = []


func _ready():
	if directon == Direction.LEFT:
		$Sprite2D.flip_h = true
		$Sensor.rotation_degrees = 180
		$HitBox.rotation_degrees = 180


func _physics_process(_delta):
	velocity.x = directon * speed
		
	
	if collitions.is_empty():
		velocity.y = 0
	else:
		scan()
	
	_auto_remove()
	move_and_slide()


# NOTE: puede generar bug si solo se usa como referencua la posicion del array
func scan():
	if collitions[0].global_position.y > global_position.y:
		velocity.y = speed * 1
	else:
		velocity.y = speed * -1
		

func _make_boom():
	if explotion:
		var boom = explotion.instantiate()
		boom.position = global_position
		add_sibling(boom)


func _auto_remove():
	if global_position.x > global.screen_size.x or global_position.x < 0:
		queue_free()


# add
func _on_sensor_body_entered(body):
	collitions.append(body)

# remove
func _on_sensor_body_exited(body):
	collitions.erase(body)
	


func _on_hit_box_area_entered(area):
	if area is EnemyHealthBox or area is PlayerHealthBox:
		area.take_damage()
	
	_make_boom()
	queue_free()
