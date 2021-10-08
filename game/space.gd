extends Spatial
class_name Space

onready var universe = $Universe;
onready var camera = $FocusCamera;

func _ready():
	# Generate the origin chunk
	var first_galaxy: Galaxy = universe.get_subformation(Vector2.ZERO);
	var first_solar_system: SolarSystem = first_galaxy.get_subformation(Vector2.ZERO);
	
	#camera.focus(first_solar_system.get_child(0));
	camera.focus(first_solar_system.planets[0]);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print_debug(galaxy_manager.get_children());
	pass
