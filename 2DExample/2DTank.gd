extends Node2D

var Bullet = preload("res://2DExample/BallisticBullet.tscn")
export var bullet_speed = 350
export var gravity = 250

var can_shoot = true

func _process(delta):
	if can_shoot:
		$Barrel.look_at(get_global_mouse_position())
		$Barrel.rotation_degrees = clamp($Barrel.rotation_degrees, -75, -15)

func _unhandled_input(event):
	if event.is_action_released("shoot") and can_shoot:
		var b = Bullet.instance()
		owner.add_child(b)
		b.connect("exploded", owner, "_on_Bullet_exploded")
		b.transform = $Barrel/Position2D.global_transform
		b.velocity = b.transform.x * bullet_speed
		b.g = gravity
		can_shoot = false
