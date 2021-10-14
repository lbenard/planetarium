extends TextureRect
tool

func _on_Icon_resized():
	rect_min_size.x = rect_size.y;
