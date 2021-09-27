extends Node

export(OpenSimplexNoise) var noise = OpenSimplexNoise.new() setget _set_noise;
var rng = RandomNumberGenerator.new();
export var reload: bool = false setget _set_reload;
export var chunk_length: int = 16 setget _set_chunk_length;
export var generation_radius: int = 1 setget _set_generation_radius;

## Chunks
class Chunk:
	var stellar = null;
	var stellar_relative_pos: Vector2 = Vector2.ZERO;
	var subdivision_flip: bool = false;

# Key: Vector2 (multiples of 1)
# Value: Chunk
export var chunks: Dictionary = {};

func _ready():
	noise.seed = 3;
	noise.octaves = 20;
	noise.persistence = 0.1;
	noise.lacunarity = 1.5;

func regenerate():
	for x in generation_radius:
		for y in generation_radius:
			var coordinates = Vector2(x, y);
			chunks[coordinates] = generate_chunk(coordinates);

func generate_chunk(coordinates):
	var chunk = Chunk.new();
	chunk.subdivision_flip = (int(coordinates.x) + int(coordinates.y) % 2) % 2 == 0
	
	var real_coordinate = coordinates * chunk_length;
	var density = noise_2d(real_coordinate);
	var base_seed = str(real_coordinate.x) + "/" + str(real_coordinate.y);
	rng.seed = base_seed.hash();
	if rng.randf() < density:
		chunk.stellar = 1;
		rng.seed = (base_seed + "x").hash();
		chunk.stellar_relative_pos.x = rng.randf_range(0.1, 0.9);
		rng.seed = (base_seed + "y").hash();
		chunk.stellar_relative_pos.y = rng.randf_range(0.1, 0.9);
	return chunk;

func noise_2d(pos: Vector2) -> float:
	return clamp((noise.get_noise_2d(pos.x, pos.y) + 1.0) / 2.0 - 0.3, 0.0, 1.0);

func _set_noise(value):
	noise = value;
	regenerate();

func _set_reload(_value):
	reload = false
	chunks = {};
	regenerate();

func _set_chunk_length(value):
	chunk_length = value;
	regenerate();

func _set_generation_radius(value):
	generation_radius = value;
	regenerate();
