extends Spatial

export onready var focused_planet: MeshInstance;
export var margin = 1.0;
export var zoom_speed = 1.0;
export var drag_speed = 2.0;

var drag_previous_pos: Vector2;
var rotation_velocity = Vector2.ZERO;

signal on_focus;

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position();

	if Input.is_action_just_pressed("3d_drag"):
		rotation_velocity = Vector2.ZERO;
		drag_previous_pos = mouse_pos;
	if Input.is_action_pressed("3d_drag"):
		var diff = get_mouse_diff(drag_previous_pos, mouse_pos);

		# Ugly way to bound the rotation without overflowing
		if diff.y < 0.0:
			diff.y = max(diff.y, -PI / 2.0 - rotation.x);
		elif diff.y > 0.0:
			diff.y = min(diff.y, PI / 2.0 - rotation.x);

		rotate_object_local(Vector3(1, 0, 0), diff.y);
		rotate_y(diff.x);
		drag_previous_pos = mouse_pos;
	if Input.is_action_just_released("3d_drag"):
		var diff = get_mouse_diff(drag_previous_pos, mouse_pos);
		rotation_velocity = diff / 5.0;

	if Input.is_action_pressed("3d_zoom"):
		scale = scale.linear_interpolate(Vector3.ZERO, zoom_speed * delta);
	if Input.is_action_pressed("3d_dezoom"):
		scale = scale.linear_interpolate(Vector3.ZERO, -zoom_speed * delta);

	rotation_velocity = rotation_velocity - rotation_velocity * delta;
	rotation += Vector3(rotation_velocity.y, rotation_velocity.x, 0);
	
	# Still need to clamp after the velocity addition
	rotation.x = clamp(rotation.x, -PI / 2.0, PI / 2.0);

func get_mouse_diff(original: Vector2, new: Vector2) -> Vector2:
	var diff =  original - new;
	diff = diff / get_viewport().size * drag_speed;
	return diff;

func focus(planet):
	focused_planet = planet;
	var camera = $Camera;
	var max_extent =  planet.get_aabb().get_longest_axis_size() * planet.scale.y;
	var min_distance = (max_extent * margin) / sin(deg2rad(camera.fov / 2.0));
	var center = focused_planet.translation;

	var offset = Vector3.ONE;
	scale = Vector3.ZERO + (offset * min_distance);
	translation = center;
	camera.look_at(center, Vector3.UP);
	emit_signal("on_focus");
