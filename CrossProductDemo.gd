extends Spatial

var a = Vector3.RIGHT
var b = Vector3.FORWARD
var c
var speed = PI/4


func _ready():
	$A.set_vec(a)
	$B.set_vec(b)
	c = a.cross(b)
	$C.set_vec(c)
	
func _input(event):
	if event.is_action_pressed("ui_select"):
		$C.show()
		
func _process(delta):
#	if Input.is_action_pressed("ui_up"):
	a = a.rotated(Vector3.UP, speed * delta)
#	if Input.is_action_pressed("ui_down"):
#		a = a.rotated(Vector3.UP, -speed * delta)
	$A.set_vec(a)
	c = a.cross(b)
	$C.set_vec(c)
	
