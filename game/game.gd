extends Node

onready var space = $Space;
onready var planet_card = $MarginContainer/VBoxContainer/HBoxContainer2/PlanetCard;

func _ready():
	# Generate the origin chunk
	var first_galaxy: Galaxy = space.universe.get_subformation(Vector2.ZERO);
	var first_solar_system: SolarSystem = first_galaxy.get_subformation(Vector2.ZERO);
	
	#camera.focus(first_solar_system.get_child(0));
	space.camera.planet_focus(first_solar_system.planets[0]);
