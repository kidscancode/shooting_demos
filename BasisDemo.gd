extends Spatial

signal next

var new_transform = Transform()

func _ready():
	var t = Transform()
	var n = Vector3(-2, 5, 4).normalized()
	$Normal.set_vec(n)
	t = align_with_y(t, n)
	
func _input(event):
	if event.is_action_pressed("ui_up"):
		emit_signal("next")
		
func align_with_y(xform, new_y):
	print("---------")
	$X.set_vec(xform.basis.x)
	$Z.set_vec(xform.basis.z)
	$Y.set_vec(xform.basis.y)
	$X2.set_vec(xform.basis.x)
	$Z2.set_vec(xform.basis.z)
	$Y2.set_vec(xform.basis.y)
	printt("1:", xform.basis)
	yield(self, "next")
	
	xform.basis.y = new_y
	$X.set_vec(xform.basis.x)
	$Z.set_vec(xform.basis.z)
	$Y.set_vec(xform.basis.y)
#	$Normal.hide()
	printt("2:", xform.basis)
	print("2: ", xform.basis.x, xform.basis.y, xform.basis.z)
	yield(self, "next")
#
	xform.basis = xform.basis.orthonormalized()
	$X.set_vec(xform.basis.x)
	$Z.set_vec(xform.basis.z)
	$Y.set_vec(xform.basis.y)
	printt("4:", xform.basis)
	yield(self, "next")

	xform.basis.x = -xform.basis.z.cross(new_y)
#	xform.basis = xform.basis.orthonormalized()
	$X.set_vec(xform.basis.x)
	$Z.set_vec(xform.basis.z)
	$Y.set_vec(xform.basis.y)
	printt("3:", xform.basis)
	print(xform.basis.x)
	yield(self, "next")
	
	xform.basis = xform.basis.orthonormalized()
	$Normal.hide()
	$X.set_vec(xform.basis.x)
	$Z.set_vec(xform.basis.z)
	$Y.set_vec(xform.basis.y)
	printt("4:", xform.basis)
	yield(self, "next")

	new_transform = xform
#	var s = $MiniTank.scale
#	$MiniTank.transform = xform
#	$MiniTank.scale = s
#	return xform
	
func _process(delta):
	$MiniTank.global_transform = $MiniTank.global_transform.interpolate_with(new_transform, 0.15)
