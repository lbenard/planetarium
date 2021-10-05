extends Spatial
class_name Formation

# https://github.com/godotengine/godot/issues/25252#issuecomment-456757786
#var Self = load("res://formation/formation.gd")

export(PackedScene) var subformation_scene;
export var procedural_seed: int;

var subformations: Dictionary = {};
var stellars: Array = [];
var parent: Formation;


# Returns a Formation or null
func get_subformation(pos: Vector2):
	if pos in subformations:
		return subformations[pos];
	else:
		var subformation = _generate_subformation(pos);
		#for stellar in subformation.stellars:
		#	add_child(stellar);
		subformations[pos] = subformation;
		return subformation;


func _generate_subformation(_pos: Vector2):
	var subformation: Formation = subformation_scene.instance();
	subformation.procedural_seed = (str(self.procedural_seed) + str(_pos)).hash();
	subformation.parent = self;
	return subformation;


func get_class() -> String:
	return "Formation";
