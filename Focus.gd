extends Spatial

export onready var focused_planet: MeshInstance;
export var margin = 1.0;
export var zoom_speed = 1.0;
export var drag_speed = 2.0;

var drag_previous_pos: Vector3;
var rotation_velocity = Vector3.ZERO;

signal on_focus;

func _ready():
	focus(get_parent().get_node("PlanetManager").get_children()[0]);

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position();
	if Input.is_action_just_pressed("3d_drag"):
		drag_previous_pos = mouse_pos;
	if Input.is_action_pressed("3d_drag"):
		var diff = get_mouse_diff(drag_previous_pos, mouse_pos);
		rotate_x(diff.y);
		rotate_y(diff.x);
		drag_previous_pos = mouse_pos;
	if Input.is_action_just_released("3d_drag"):
		var diff = get_mouse_diff(drag_previous_pos, mouse_pos);
		rotation_velocity = diff;
	if Input.is_action_pressed("3d_zoom"):
		scale = scale.linear_interpolate(Vector3.ZERO, zoom_speed * delta);
	if Input.is_action_pressed("3d_dezoom"):
		scale = scale.linear_interpolate(Vector3.ZERO, -zoom_speed * delta);
	rotation += rotation_velocity;
	rotation_velocity = rotation_velocity.lerp(Vector3.ZERO, rotation_velocity, 0.9 * delta);

func get_mouse_diff(original: Vector3, new: Vector3) -> Vector3:
	var diff =  original - new;
	diff = diff / get_viewport().size * drag_speed;
	return diff;

func focus(planet):
	focused_planet = planet;
	var camera = $Camera;
	var max_extent =  planet.get_aabb().get_longest_axis_size() * planet.scale.y;
	var min_distance = (max_extent * margin) / sin(deg2rad(camera.fov / 2.0));
	var center = Vector3.ZERO;

	camera.look_at(center, Vector3.UP);
	var offset = Vector3.ONE;
	scale = center + (offset * min_distance);
	emit_signal("on_focus");
