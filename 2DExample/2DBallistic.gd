extends Node2D

onready var tank = $"2DTank"
onready var barrel = $"2DTank/Barrel"
onready var muzzle = $"2DTank/Barrel/Position2D"
onready var line = $Line2D

var Explosion = preload("res://2DExample/Explosion.tscn")

var dt = 1.0/60
var num_points = 250

func _ready():
	$Ground/CollisionPolygon2D.polygon = $Ground/Polygon2D.polygon

func update_trajectory():
	line.clear_points()
	var v = barrel.global_transform.x * tank.bullet_speed
	var p = muzzle.global_position
	for i in num_points:
		line.add_point(p)
		v.y += tank.gravity * dt
		p += v * dt
		if p.y > $Ground.position.y - 25:
			break

func _process(delta):
	if Input.is_action_pressed("shoot"):
		line.show()
		update_trajectory()
		
func _on_Bullet_exploded(pos):
	var e = Explosion.instance()
	add_child(e)
	e.position = pos
	tank.can_shoot = true
	line.hide()
