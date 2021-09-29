extends Spatial

onready var galaxy_manager = $GalaxyManager;
onready var camera = $FocusCamera;

func _ready():
	# Generate the origin chunk
	var first_galaxy: Galaxy = galaxy_manager.get_chunk(Vector2.ZERO).stellars[0];
	var first_solar_system = first_galaxy.solar_system_manager.get_chunk(Vector2.ZERO).stellars[0];
	
	camera.focus(first_solar_system.planet_manager.get_child(0));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print_debug(galaxy_manager.get_children());
	pass
