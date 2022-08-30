extends Spatial

export (PackedScene) var Explosion


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("shoot"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_Bullet_exploded(pos):
	var e = Explosion.instance()
	add_child(e)
	e.transform.origin = pos
#	e.emitting = true
#	yield(get_tree().create_timer(e.lifetime), "timeout")
#	e.queue_free()
