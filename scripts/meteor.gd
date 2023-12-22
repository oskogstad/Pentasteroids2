extends CharacterBody2D

var MAX_SPEED: int = 400
var speed_x: float = 0
var speed_y:  float = 0

enum StartingEdge { Top, Bottom, Left, Right }

func set_random_position():
	var vPort = get_viewport()
	var vPortSize = vPort.size
	
	var startingEdge = randi() % 4
	var camPos = vPort.get_camera_2d().get_screen_center_position()
	
	match startingEdge: 
		StartingEdge.Top:
			global_position.y = camPos.y - vPortSize.y/2
			global_position.x = get_random_axis_position(camPos.x, vPortSize.x)
		StartingEdge.Bottom:
			global_position.y = camPos.y + vPortSize.y/2
			global_position.x = get_random_axis_position(camPos.x, vPortSize.x)
		StartingEdge.Left:
			global_position.y = get_random_axis_position(camPos.y, vPortSize.y)
			global_position.x = camPos.x - vPortSize.x/2
		StartingEdge.Right:
			global_position.y = get_random_axis_position(camPos.y, vPortSize.y)
			global_position.x = camPos.x + vPortSize.x/2

func get_random_axis_position(camPos: int, vPortSize: int):
	return randi_range(camPos - vPortSize/2, camPos + vPortSize/2)
			
func _ready():
	set_random_position()

func _physics_process(delta):
	var camPos = get_viewport().get_camera_2d().get_screen_center_position()
	velocity = global_position.direction_to(camPos) * MAX_SPEED
	move_and_slide()
	rotation_degrees += 1
	
	if (Input.is_key_pressed(KEY_0)):
		set_random_position()
