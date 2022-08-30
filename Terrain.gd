extends Spatial

export var size = 100  # map size
export var height = 20  # higher mountains
export var detail = 5  # smaller triangles
export var smoothness = 6  # less spiky
export var period = 60  # less spiky

func _ready():
	var noise = OpenSimplexNoise.new()
	noise.period = period
	noise.octaves = smoothness
	randomize()
	noise.seed = randi()
	
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(size, size)
	plane_mesh.subdivide_width = size  / detail
	plane_mesh.subdivide_depth = size / detail
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	
	var array_plane = surface_tool.commit()
	
	var data_tool = MeshDataTool.new()
	data_tool.create_from_surface(array_plane, 0)
	
	for i in data_tool.get_vertex_count():
		var vertex = data_tool.get_vertex(i)
		vertex.y = noise.get_noise_2d(vertex.x, vertex.z) * height
		data_tool.set_vertex(i, vertex)
	
	for i in array_plane.get_surface_count():
		array_plane.surface_remove(i)
		
	data_tool.commit_to_surface(array_plane)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(array_plane, 0)
	surface_tool.generate_normals()
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.set_surface_material(0, load("res://terrain_shader.tres"))
	mesh_instance.create_trimesh_collision()
	add_child(mesh_instance)
	
	
#func _process(delta):
#	$Spatial.rotate_y(0.5 * delta);
