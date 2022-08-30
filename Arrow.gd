extends Spatial

export (Color) var color = Color(0, 1, 0)

var mat = preload("res://arrow_material.tres").duplicate()

func _ready():
	mat.albedo_color = color
	$Shaft.mesh = $Shaft.mesh.duplicate()
	$Shaft.set_surface_material(0, mat)
	$Shaft/Point.set_surface_material(0, mat)
#	set_vec(Vector3(0, 3, 3))

func set_vec(vec):
	var l = vec.length() * 2.5
	$Shaft.mesh.height = l
	$Shaft.transform.origin.z = -l / 2
	$Shaft/Point.transform.origin.y = -l / 2 - 0.2
	if vec.normalized() == transform.basis.y:
		look_at(vec, transform.basis.z)
	else:
		look_at(vec, transform.basis.y)
