extends RigidBody2D

var MAX_SPEED: int = 400
var spinDegrees = randf_range(-2, 2)

var exploding = false;

enum StartingEdge { Top, Bottom, Left, Right }

func set_random_position(vPort: Viewport):
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

func setup(vPort: Viewport):
	var textureNumber = randi_range(1, 1)
	var texturePathTemplate = "res://sprites/meteor_%d.png"
	var texturePath = texturePathTemplate % textureNumber
	$MeteorSprite.texture = load(texturePath)
	set_random_position(vPort)

func _physics_process(delta):
	var camPos = get_viewport().get_camera_2d().get_screen_center_position()
	linear_velocity = global_position.direction_to(camPos) * MAX_SPEED * delta
	var col = move_and_collide(linear_velocity)
	if col:
		var collider = col.get_collider()
		var name = collider.get_name()
		
		print(self.name + " collided with " + name)
		if name == "PlayerBody":
			collider.take_dmg()
		else:
			collider._on_collision()
		_on_collision()

func _on_collision():
	if !exploding:
		exploding = true
		var parent = get_parent()
		parent.remove_child(self)
