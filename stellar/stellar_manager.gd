extends Node
class_name StellarManager

class Chunk:
	var stellars: Array = [];

var chunks = {};
export(PackedScene) var stellar_scene;
export(OpenSimplexNoise) var noise = OpenSimplexNoise.new()
export var noise_seed: int = randi();

#export var chunk_length: int = 16;

func _init():
	print_debug("Created new stellar manager " + get_class());

func _ready():
	get_chunk(Vector2.ZERO);

func get_chunk(pos: Vector2) -> Chunk:
	if pos in chunks:
		return chunks[pos];
	else:
		print_debug("Spawn new stellar at chunk " + str(pos));
		#print_debug(stellar_scene);
		var chunk = _generate_chunk(pos);
		for stellar in chunk.stellars:
			add_child(stellar);
		chunks[pos] = chunk;
		return chunk;

# To override
func _generate_chunk(pos: Vector2) -> Chunk:
	return Chunk.new();

func get_class() -> String:
	return "StellarManager";
