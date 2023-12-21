extends CharacterBody2D

var speed: float = 1500
var acceleration: float = 15000
var friction: float = acceleration / speed
const tractionValue: int = 1

func _process(delta: float) -> void:
	apply_traction(delta)
	apply_friction(delta)

func _physics_process(delt: float) -> void:
	move_and_slide()
	look_at(get_global_mouse_position())
	rotation += 90
	
func apply_traction(delta: float) -> void:
	var traction: Vector2 = Vector2()
	
	if (Input.is_action_pressed("move_left")):
		traction.x -= tractionValue
	
	if (Input.is_action_pressed("move_right")):
		traction.x += tractionValue
	
	if (Input.is_action_pressed("move_forward")):
		traction.y -= tractionValue
	
	if (Input.is_action_pressed("move_backward")):
		traction.y += tractionValue
	
	traction = traction.normalized()
	
	velocity += traction * acceleration * delta
	
func apply_friction(delta: float) -> void:
	velocity -= velocity * friction * delta
