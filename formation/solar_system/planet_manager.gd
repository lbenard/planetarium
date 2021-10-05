extends Node

var rng: RandomNumberGenerator;
var gaussian_rng: GaussianRandom;
export var procedural_seed: int;
# Gaussian distribution randomly picking a number of planets (at least 1)
export var planets_amount: int;
export onready var sun = get_parent().get_node("Sun");
onready var sun_mesh: SphereMesh = sun.mesh;

func _init():
	pass
	# TODO:
	# rng.seed =

func _ready():
	rng = RandomNumberGenerator.new();
	print_debug(procedural_seed);
	gaussian_rng = GaussianRandom.new();
	gaussian_rng.rng = rng;
	planets_amount = int(gaussian_rng.gaussian_clamp(0.0, 5.0, 1.0))
	var last_planet: Planet;
	
	for n in planets_amount:
		#var planet_seed = (str(procedural_seed) + str(n)).hash();
		var new_planet: Planet;
		var radius = gaussian_rng.gaussian_clamp(1.0, 3.0, 0.5, 4.0);
		
		var distance;
		if n == 0:
			# First planet gets generated close to the star
			distance = gaussian_rng.gaussian_clamp(sun_mesh.radius * 6, sun_mesh.radius, sun_mesh.radius * 3);
		else:
			# The others gets generated further starting from the last one
			#distance = last_planet.translation.x + gaussian_rng.gaussian_clamp(first_planet.translation.x, last_planet.translation.x * 3, last_planet.translation.x * 2);
			distance = last_planet.translation.x + gaussian_rng.gaussian_clamp(sun_mesh.radius * 3, sun_mesh.radius, sun_mesh.radius * 2);
		
		var color = Color.from_hsv(rng.randf(), 0.5, 1.0);
		new_planet = Planet.new();
		new_planet.init(radius, distance, color);
		
		print_debug("Spawned planet at a distance of " + str(distance));
		
		new_planet.add_to_group("planet");
		
		# Spawn the new planet
		add_child(new_planet);
		last_planet = new_planet;
