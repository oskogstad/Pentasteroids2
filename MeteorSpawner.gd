extends Timer
var meteor_number = 1

func spawn_meteor():
	var Meteor = load("res://meteor.tscn")
	var instance = Meteor.instantiate()
	instance.name = "%d - Meteor" % meteor_number
	var vPort = get_parent().get_viewport()
	instance.setup(vPort)
	add_child(instance)
	meteor_number += 1

#func _physics_process(delta):
func _on_timeout():
	spawn_meteor()
	wait_time = randi_range(2, 4)
