extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 4
export var rot_speed = 0.85

var velocity = Vector3.ZERO

func _ready():
	print(Input)
	
func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN*2, Vector3.UP, true)
	var normal = $RayCast.get_collision_normal()
	var xform = align_with_y(global_transform, normal)
	global_transform = global_transform.interpolate_with(xform, 0.2)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
	
	
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
	
	
