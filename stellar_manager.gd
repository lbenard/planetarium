extends Node
class_name StellarManager

var stellars = {};
export(PackedScene) var scene;

func _init():
	pass

func init(pos: Vector2):
	self.pos = pos;

func _ready():
	cleanup();
	get_stellar(Vector2.ZERO);

func get_stellar(pos: Vector2):
	if pos in stellars:
		return stellars[pos];
	else:
		var new_scene = scene.instance();
		new_scene.position
		add_child(new_scene);
		stellars[pos] = new_scene;
		return new_scene;

func cleanup():
	for n in get_children():
		n.queue_free();
	stellars = {};
