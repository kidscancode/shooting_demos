extends Spatial

func _input(event):
	if event.is_action_pressed("ui_up"):
		$RigidBody.apply_central_impulse(Vector3.RIGHT)
