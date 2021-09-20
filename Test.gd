extends Label

onready var camera = get_parent().get_parent().get_node("FocusCamera/Camera");
onready var sun = get_parent().get_parent().get_node("Sun");

func _ready():
	pass

func _process(_delta):
	if camera.is_position_behind(sun.translation):
		hide();
	else:
		var sun_radius = sun.mesh.get_aabb().get_support(Vector3(0, 1, 0)).y;
		var sun_top = Vector3(0, sun_radius, 0);
		var sun_bottom = Vector3(0, -sun_radius, 0);
		var viewport_sun_diameter = camera.unproject_position(sun_top).y - camera.unproject_position(sun_bottom).y;
		print_debug(viewport_sun_diameter / get_viewport().size.y);
		#get("custom_fonts/font").set_size(viewport_sun_diameter);
		rect_scale = Vector2.ONE * viewport_sun_diameter / get_viewport().size.y;
		rect_position = camera.unproject_position(sun.translation - sun_top * 1.2) - (rect_size / 2);
		
