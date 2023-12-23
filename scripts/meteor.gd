extends CharacterBody2D

var MAX_SPEED: int = 400
var spinDegrees = randf_range(-2, 2)

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
	var textureNumber = randi_range(1, 4)
	var texturePathTemplate = "res://sprites/meteor_%d.png"
	var texturePath = texturePathTemplate % textureNumber
	$MeteorSprite.texture = load(texturePath)
	set_random_position()

func _physics_process(delta):
	var camPos = get_viewport().get_camera_2d().get_screen_center_position()
	velocity = global_position.direction_to(camPos) * MAX_SPEED
	move_and_slide()
	rotation_degrees += spinDegrees
