extends KinematicBody


export var gravity = Vector3.DOWN * 10
export var speed = 4.0
export var spin = 0.1

var velocity = Vector3.ZERO


func get_input():
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("back"):
		velocity += transform.basis.z * speed
	velocity.y = vy
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x != 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
		if event.relative.y != 0:
			$Pivot.rotate_x(-event.relative.y/50)
			$Pivot.rotation_degrees.x = clamp($Pivot.rotation_degrees.x, -35, 35)

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
