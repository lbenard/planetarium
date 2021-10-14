extends Formation
class_name SolarSystem

onready var sun = $Sun;
onready var sun_mesh: SphereMesh = sun.mesh;
var rng: RandomNumberGenerator;
var gaussian_rng: GaussianRandom;

# Gaussian distribution randomly picking a number of planets (at least 1)
var planets_amount: int;
var planets: Array = [];

func _ready():
	stellars.push_back(sun);
	rng = RandomNumberGenerator.new();
	gaussian_rng = GaussianRandom.new();
	gaussian_rng.rng = rng;
	planets_amount = int(gaussian_rng.gaussian_clamp(0.0, 5.0, 1.0))
	var last_planet: Planet;
	
	for n in planets_amount:
		#var planet_seed = (str(procedural_seed) + str(n)).hash();
		var new_planet: Planet = Planet.new();
		var radius = gaussian_rng.gaussian_clamp(1.0, 3.0, 0.5, 4.0);
		
		var distance;
		if n == 0:
			# First planet gets generated close to the star
			distance = gaussian_rng.gaussian_clamp(sun_mesh.radius * 6, sun_mesh.radius, sun_mesh.radius * 3);
			
			# First planet also has a specific set of starting resources
			new_planet.atmosphere[Elements.standard.oxygen] = 10;
			new_planet.atmosphere[Elements.standard.nitrogen] = 10;
			
			new_planet.elements[Elements.standard.hydrogen] = 20;
			new_planet.elements[Elements.standard.silicon] = 10;
			new_planet.elements[Elements.standard.carbon] = 5;
			
			BuildingManager.test_building.build_on(new_planet);
		else:
			# The others gets generated further starting from the last one
			#distance = last_planet.translation.x + gaussian_rng.gaussian_clamp(first_planet.translation.x, last_planet.translation.x * 3, last_planet.translation.x * 2);
			distance = last_planet.translation.x + gaussian_rng.gaussian_clamp(sun_mesh.radius * 3, sun_mesh.radius, sun_mesh.radius * 2);
		
		var color = Color.from_hsv(rng.randf(), 0.5, 1.0);
		new_planet.name = 'Planet ' + str(n + 1);
		new_planet.init(sun, radius, distance, color);
		
		planets.push_back(new_planet);
		stellars.push_back(new_planet);
		
		# Spawn the new planet
		add_child(new_planet);
		last_planet = new_planet;
