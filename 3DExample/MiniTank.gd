extends KinematicBody

export (PackedScene) var Bullet
export var gravity = Vector3.DOWN * 10
export var speed = 4
export var rot_speed = 0.85
export var cam_speed = 0.55

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
	if Input.is_action_just_pressed("shoot"):
		var b = Bullet.instance()
		owner.add_child(b)
		b.connect("exploded", owner, "_on_Bullet_exploded")
		b.transform = $Head_Cube001/Pivot/Cannon_Cube005/Muzzle.global_transform
		b.velocity = -b.transform.basis.z * b.muzzle_velocity
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:# and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var relative = event.relative / get_viewport().size
		$Head_Cube001.rotate_y(lerp(0, -cam_speed, relative.x))
		$Head_Cube001/Pivot.rotate_x(lerp(0, cam_speed, relative.y))
		$Head_Cube001/Pivot.rotation_degrees.x = clamp($Head_Cube001/Pivot.rotation_degrees.x, -12, 12)


func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN*2, Vector3.UP, true)
	if $RayCast.is_colliding():
		var n = $RayCast.get_collision_normal()
#	if n.dot(transform.basis.y) > 0.9:
		var xform = align_with_y(global_transform, n)
		global_transform = global_transform.interpolate_with(xform, 0.2)


func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
