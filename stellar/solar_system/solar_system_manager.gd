extends StellarManager
class_name SolarSystemManager

func _ready():
	pass

var rng: RandomNumberGenerator = RandomNumberGenerator.new();
var noise = OpenSimplexNoise.new();

func _generate_chunk(pos: Vector2) -> Chunk:
	var chunk = ._generate_chunk(pos);
	var real_coordinate = pos * chunk_length;
	var density = _noise_2d(real_coordinate);
	var base_seed = str(real_coordinate.x) + "/" + str(real_coordinate.y);
	rng.seed = base_seed.hash();
	
	# Special case at the origin because we need one stellar to start from
	if rng.randf() < density or pos == Vector2.ZERO:
		var galaxy = stellar_scene.instance()
		rng.seed = (base_seed + "x").hash();
		galaxy.chunk_relative_pos.x = rng.randf_range(0.1, 0.9);
		rng.seed = (base_seed + "y").hash();
		galaxy.chunk_relative_pos.y = rng.randf_range(0.1, 0.9);
		chunk.stellars.push_back(galaxy);
	return chunk;

func _noise_2d(pos: Vector2) -> float:
	return clamp((noise.get_noise_2d(pos.x, pos.y) + 1.0) / 2.0 - 0.3, 0.0, 1.0);

func get_class() -> String:
	return "SolarSystemManager";
