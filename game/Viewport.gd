extends Viewport
tool

func _on_ViewportContainer_resized():
	size = (get_parent() as ViewportContainer).rect_size;
