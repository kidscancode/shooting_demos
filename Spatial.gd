extends Spatial

func _ready():
	print(global_transform)
	global_transform *= $DirectionalLight.global_transform
	print(global_transform)
	
func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var pos = Vector2(click_position.x, click_position.z)
		pos = pos / $MeshInstance.mesh.size + Vector2(0.5, 0.5);
		print(pos)
		$MeshInstance.mesh.material.set_shader_param("pos", pos)
