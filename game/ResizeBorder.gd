extends Panel

var dragged: bool = false;

func _on_ResizeBorder_gui_input(event):
	if event is InputEventMouseButton:
		dragged = event.pressed;
	if dragged and event is InputEventMouseMotion:
		var relative_h = event.relative.x;
		if get_parent().origin == HResizable.Origin.RIGHT:
			relative_h = -relative_h
		(get_parent() as HBoxContainer).rect_min_size.x += relative_h;
