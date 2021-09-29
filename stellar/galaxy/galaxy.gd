extends Stellar
class_name Galaxy

onready var solar_system_manager: SolarSystemManager = $SolarSystemManager;

#export(OpenSimplexNoise) var noise = OpenSimplexNoise.new();
#var solar_system_scene = preload("res://solar_system.tscn");
#var solar_systems = {};
#export var noise_seed = 0;
#export var pos: Vector2;

func _init():
	pass

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
