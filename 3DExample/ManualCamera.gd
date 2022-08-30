extends Camera

export (NodePath) var target_path  = null
export var target_distance = 3.0
export var target_height = 2.0
export var lerp_speed = 10.0

var target = null
var last_lookat

func _ready():
	target = get_node(target_path)
	last_lookat = target.global_transform.origin
	
func _physics_process(delta):
	var dv = global_transform.origin - target.global_transform.origin
	var target_pos = global_transform.origin
	
	dv.y = 0.0
	if dv.length() > target_distance:
		dv = dv.normalized() * target_distance
		dv.y = target_height
		target_pos = target.global_transform.origin + dv
	else:
		target_pos.y = target.global_transform.origin.y + target_height
		
	global_transform.origin = global_transform.origin.linear_interpolate(target_pos, delta * lerp_speed)
	last_lookat = last_lookat.linear_interpolate(target.global_transform.origin, delta * lerp_speed)
	look_at(last_lookat, Vector3.UP)
