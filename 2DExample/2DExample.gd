extends Node2D


func _ready():
	print($TileMap.get_cell(0, 0))
	var map_size = $TileMap.get_used_rect()
	var start = map_size.position * $TileMap.cell_size
	var end = map_size.end * $TileMap.cell_size
	$Player/Camera2D.limit_left = start.x
	$Player/Camera2D.limit_right = end.x
	$Player/Camera2D.limit_top = start.y
	$Player/Camera2D.limit_bottom = end.y
