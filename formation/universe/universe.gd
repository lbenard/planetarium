extends Formation
class_name Universe

var rng: RandomNumberGenerator;
var noise: OpenSimplexNoise;


func _init():
	#chunk_length = 16;
	rng = RandomNumberGenerator.new();
	noise = OpenSimplexNoise.new();


func _ready():
	get_subformation(Vector2.ZERO);


func _generate_subformation(pos: Vector2):
	var real_coordinate = pos * 16;
	var density = _noise_2d(real_coordinate);
	
	# Special case at the origin because we need one stellar to start from
	if rng.randf() < density or pos == Vector2.ZERO:
		var galaxy = ._generate_subformation(pos);
		#rng.seed = (str(galaxy.procedural_seed) + "x").hash();
		#galaxy.chunk_relative_pos.x = rng.randf_range(0.1, 0.9);
		#rng.seed = (str(galaxy.procedural_seed) + "y").hash();
		#galaxy.chunk_relative_pos.y = rng.randf_range(0.1, 0.9);
		add_child(galaxy);
		return galaxy;
	return null;


func _noise_2d(pos: Vector2) -> float:
	return clamp((noise.get_noise_2d(pos.x, pos.y) + 1.0) / 2.0 - 0.3, 0.0, 1.0);
