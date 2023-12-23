extends Timer

func _ready():
	spawn_meteor()

func spawn_meteor():
	var Meteor = load("res://meteor.tscn")
	var instance = Meteor.instantiate()
	add_child(instance)

func _on_timeout():
	spawn_meteor()
	print("timer done")
	wait_time = randi_range(1, 3) # Replace with function body.
