extends KinematicBody2D

export var speed = 200
export (PackedScene) var Bullet

var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		velocity += transform.x * speed
	if Input.is_action_pressed("back"):
		velocity -= transform.x * speed
	if Input.is_action_just_pressed("shoot"):
		shoot()


func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	velocity = move_and_slide(velocity)


func shoot():
	var b = Bullet.instance()
##	add_child(b)
##	b.transform = $Muzzle.transform
	owner.add_child(b)
	b.transform = $Muzzle.global_transform

