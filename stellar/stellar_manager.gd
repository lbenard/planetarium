extends Node
class_name StellarManager

class Chunk:
	var stellars: Array = [];

var chunks: Dictionary;
export(PackedScene) var stellar_scene;
export var chunk_length: int = 16;

func _init():
	chunks = {};

func get_chunk(pos: Vector2) -> Chunk:
	if pos in chunks:
		return chunks[pos];
	else:
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
