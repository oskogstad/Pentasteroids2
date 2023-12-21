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
	print(camPos.x)
	print(camPos.y)
	
	match startingEdge: 
		StartingEdge.Top:
			print("starting top")
			global_position.y = camPos.y - vPortSize.y/2
			global_position.x = randi_range(camPos.x - (vPortSize.x/2), camPos.x + (vPortSize.x/2))
		StartingEdge.Bottom:
			print("starting bottom")
			global_position.y = camPos.y + vPortSize.y/2
			global_position.x = randi_range(camPos.x - (vPortSize.x/2), camPos.x + (vPortSize.x/2))
		StartingEdge.Left:
			print("starting left")
			global_position.y = randi_range(camPos.y - (vPortSize.y/2), camPos.y + (vPortSize.y/2))
			global_position.x = camPos.x - vPortSize.x/2
		StartingEdge.Right:
			print("starting right")
			global_position.y = randi_range(camPos.y - (vPortSize.y/2), camPos.y + (vPortSize.y/2))
			global_position.x = camPos.x + vPortSize.x/2
	var postring = "new pos: %s"
	print(postring % position)
			
func _ready():
	set_random_position()
	#speed_x = randf_range(-MAX_SPEED, MAX_SPEED)
	#speed_y = randf_range(-MAX_SPEED, MAX_SPEED)

func _physics_process(delta):
	var camPos = get_viewport().get_camera_2d().get_screen_center_position()
	velocity = position.direction_to(camPos) * MAX_SPEED
	move_and_slide()
	
	if (Input.is_key_pressed(KEY_0)):
		set_random_position()
	#position.x += speed_x
	#position.y += speed_y
