extends Formation
class_name Galaxy

var rng: RandomNumberGenerator = RandomNumberGenerator.new();
var noise = OpenSimplexNoise.new();


func _ready():
	get_subformation(Vector2.ZERO);


func _generate_subformation(pos: Vector2):
	var real_coordinate = pos * 16;
	var density = _noise_2d(real_coordinate);
	rng.seed = procedural_seed;
	
	# Special case at the origin because we need one stellar to start from
	if rng.randf() < density or pos == Vector2.ZERO:
		var solar_system = ._generate_subformation(pos);
		#rng.seed = (str(solar_system.procedural_seed) + "x").hash();
		#solar_system.chunk_relative_pos.x = rng.randf_range(0.1, 0.9);
		#rng.seed = (str(solar_system.procedural_seed) + "y").hash();
		#solar_system.chunk_relative_pos.y = rng.randf_range(0.1, 0.9);
		add_child(solar_system);
		return solar_system;
	return null;


func _noise_2d(pos: Vector2) -> float:
	return clamp((noise.get_noise_2d(pos.x, pos.y) + 1.0) / 2.0 - 0.3, 0.0, 1.0);

#export(OpenSimplexNoise) var noise = OpenSimplexNoise.new();
#var solar_system_scene = preload("res://solar_system.tscn");
#var solar_systems = {};
#export var noise_seed = 0;
#export var pos: Vector2;

#func init(noise_seed: int, pos: Vector2):
#	noise.seed = noise_seed;
#	self.noise_seed = noise_seed;
#	self.pos = pos;

#func _ready():
#	cleanup();
#	get_solar_system(Vector2.ZERO);

#func get_solar_system(pos: Vector2) -> SolarSystem:
#	if pos in solar_systems:
#		return solar_systems[pos];
#	else:
#		var new_solar_system = solar_system_scene.instance();
#		add_child(new_solar_system);
#		solar_systems[pos] = new_solar_system;
#		return new_solar_system;

#func cleanup():
#	for n in get_children():
#		n.queue_free();
#	solar_systems = {};
