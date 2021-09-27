extends Node
class_name StellarManager

class Chunk:
	var stellar = null;
	var stellar_relative_pos: Vector2 = Vector2.ZERO;

var chunks = {};
export var noise_seed: int = randi();
export(PackedScene) var stellar_scene;

export var chunk_length: int = 16;

func _init():
	pass

func _ready():
	get_chunk(Vector2.ZERO);

func get_chunk(pos: Vector2) -> Chunk:
	if pos in chunks:
		return chunks[pos];
	else:
		var new_scene = stellar_scene.instance();
		new_scene.position
		add_child(new_scene);
		chunks[pos] = new_scene;
		return new_scene;
