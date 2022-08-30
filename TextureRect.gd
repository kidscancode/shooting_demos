extends TextureRect

func _ready():
	var styleBox = StyleBoxFlat.new()
	styleBox.bg_color = Color(1, 0, 0)
	$ProgressBar.set("custom_styles/fg", styleBox)
	styleBox = StyleBoxFlat.new()
	styleBox.bg_color = Color(1, 1, 0)
	$ProgressBar.set("custom_styles/bg", styleBox)
