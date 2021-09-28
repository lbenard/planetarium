extends StellarManager

var chunk_length = 16;
var rng: RandomNumberGenerator = RandomNumberGenerator.new();

func _generate_chunk(pos: Vector2) -> Chunk:
	var chunk = ._generate_chunk(pos);
	var real_coordinate = pos * chunk_length;
	var density = _noise_2d(real_coordinate);
	var base_seed = str(real_coordinate.x) + "/" + str(real_coordinate.y);
	rng.seed = base_seed.hash();
	
	# Special case at the origin because we need one stellar to start from
	if rng.randf() < density or pos == Vector2.ZERO:
		chunk.stellar = 1;
		rng.seed = (base_seed + "x").hash();
		chunk.stellar_relative_pos.x = rng.randf_range(0.1, 0.9);
		rng.seed = (base_seed + "y").hash();
		chunk.stellar_relative_pos.y = rng.randf_range(0.1, 0.9);
	return chunk;

func _noise_2d(pos: Vector2) -> float:
	return clamp((noise.get_noise_2d(pos.x, pos.y) + 1.0) / 2.0 - 0.3, 0.0, 1.0);
