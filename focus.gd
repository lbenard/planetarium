extends Spatial

export onready var focused_planet: Planet;
export var margin = 1.0;
export var zoom_speed = 1.0;
export var drag_speed = 2.0;

var drag_previous_pos: Vector2;
var rotation_velocity = Vector2.ZERO;

signal on_focus;

func _process(delta):
	if focused_planet:
		translation = focused_planet.translation;
	
	var mouse_pos = get_viewport().get_mouse_position();
	
	if Input.is_action_just_pressed("3d_drag"):
		rotation_velocity = Vector2.ZERO;
		drag_previous_pos = mouse_pos;
	if Input.is_action_pressed("3d_drag"):
		var diff = _get_mouse_diff(drag_previous_pos, mouse_pos);
		
		# Ugly way to bound the rotation without overflowing
		if diff.y < 0.0:
			diff.y = max(diff.y, -PI / 2.0 - rotation.x);
		elif diff.y > 0.0:
			diff.y = min(diff.y, PI / 2.0 - rotation.x);
		
		rotate_object_local(Vector3(1, 0, 0), diff.y);
		rotate_y(diff.x);
		drag_previous_pos = mouse_pos;
	if Input.is_action_just_released("3d_drag"):
		var diff = _get_mouse_diff(drag_previous_pos, mouse_pos);
		rotation_velocity = diff / 5.0;

	if Input.is_action_pressed("3d_zoom") || Input.is_action_pressed("3d_zoom_mouse"):
		var speed = zoom_speed;
		if Input.is_action_pressed("3d_zoom_mouse"):
			speed *= 10;
		scale = scale.linear_interpolate(Vector3.ZERO, speed * delta);
	if Input.is_action_pressed("3d_dezoom") || Input.is_action_pressed("3d_dezoom_mouse"):
		var speed = zoom_speed;
		if Input.is_action_pressed("3d_dezoom_mouse"):
			speed *= 10;
		scale = scale.linear_interpolate(Vector3.ZERO, -speed * delta);
	
	if Input.is_action_just_pressed("ui_focus_next"):
		var solar_system: SolarSystem = focused_planet.get_parent();
		var next_planet_id = (solar_system.planets.find(focused_planet) + 1) % solar_system.planets.size();
		focus(solar_system.planets[next_planet_id]);
	
	rotation_velocity = rotation_velocity - rotation_velocity * delta;
	rotation += Vector3(rotation_velocity.y, rotation_velocity.x, 0);
	
	# Still need to clamp after the velocity addition
	rotation.x = clamp(rotation.x, -PI / 2.0, PI / 2.0);

func _get_mouse_diff(original: Vector2, new: Vector2) -> Vector2:
	var diff =  original - new;
	diff = diff / get_viewport().size * drag_speed;
	return diff;

func focus(planet):
	focused_planet = planet;
	var camera = $Camera;
	# Multiplied so the max radius doesn't fill the screen
	var max_extent = Planet.max_planet_radius * 1.5;
	#print_debug("max_extent: " + str(max_extent));
	#print_debug("planet.scale.y: " + str(planet.scale.y));
	var min_distance = (max_extent * margin) / sin(deg2rad(camera.fov / 2.0));
	var center = focused_planet.translation;
	
	var offset = Vector3.ONE;
	scale = Vector3.ZERO + (offset * min_distance);
	translation = center;
	camera.look_at(center, Vector3.UP);
	emit_signal("on_focus");
