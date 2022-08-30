extends Area2D

signal exploded

var g = 150

var velocity = Vector2.ZERO

func _process(delta):
	velocity.y += g * delta
	rotation = velocity.angle()
	position += velocity * delta


func _on_BallisticBullet_body_entered(body):
	emit_signal("exploded", position + transform.x * 37)
	queue_free()
