extends CharacterBody2D


@export var health: int = 60
@export var immunity: bool = true
@export var speed: float = 15.0
@export var zigzag_speed: float = 8.0 
@export var to_down: bool = false

var _on_viewport: Vector2 = Vector2(155.0, 42.0)
var _offset_vieport: Vector2 = Vector2(197.0, 42.0)
var _is_on_zigzag: bool = false


func _ready():
	$AnimatedSprite2D.play("default")


func _physics_process(_delta):
	_apply_movement()


func _apply_movement():
	if global_position.x > _on_viewport.x:
		velocity.x = -speed
	else:
		velocity.x = 0
		immunity = false
	
	start_move_on_zigszag()
	move_and_slide()


func start_move_on_zigszag():
	if not immunity:
		_apply_zigzag()
	

func _apply_zigzag():
	# switch direction on up or down
	var dir = 1 if to_down else -1
	velocity.y = zigzag_speed * dir

	
func handler_zigzag_direction():
	to_down = not to_down



