extends Label

func _process(_delta):
	var name = "";
	if owner.get_node("Space").camera.focused_planet != null:
		name = owner.get_node("Space").camera.focused_planet.name;
	text = name;
