# Example KinematicBody movement.
extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 4  # m/s
export var rot_speed = 0.85  # radians/s

var velocity = Vector3.ZERO


func get_input(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("back"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("right"):
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("left"):
		rotate_y(rot_speed * delta)
	velocity.y = vy


func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
#	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN*2, Vector3.UP, true)
#	var n = $RayCast.get_collision_normal()
#	global_transform = align_with_y(global_transform, n)
#	var xform = align_with_y(global_transform, n)
#	global_transform = global_transform.interpolate_with(xform, 0.2)
#	for i in get_slide_count():
#		var c = get_slide_collision(i)
#		global_transform = align_with_y(global_transform, c.normal)


func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
