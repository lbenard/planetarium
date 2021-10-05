extends Spatial
class_name Stellar

var procedural_seed: int;
var resources_set: ResourcesSet = null;

func _ready():
	print_debug("Stellar " + name + " has resources set: " + str(resources_set));
